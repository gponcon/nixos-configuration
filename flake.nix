{
  description = "Main NixOS Flake";

# Sera utile avec colmena
#  nixConfig = {
#    extra-trusted-substituters = [
#      "https://cache.garnix.io"
#      "https://nix-community.cachix.org"
#    ];
#  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    
    # Utilisation de home manager comme module flake
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    deploy-rs.url = "github:serokell/deploy-rs";

# NE FONCTIONNE PAS POUR LE MOMENT
#    colmena.url = "github:zhaofengli/colmena";
#    colmena.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {

    # "nlt" est mon hostname
    nixosConfigurations.nlt = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { hostname = "nlt"; };
      modules = [
        ./configuration.nix

        # Utilisation de home manager comme module flake
        home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.gponcon = import ./users/gponcon/home.nix;

            # Optionally, use home-manager.extraSpecialArgs to pass
            # arguments to home.nix
          }
      ];
    };

    # VM de test
    nixosConfigurations.test = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { hostname = "test"; };
      modules = [
        ./hosts/test.nix
        home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.gponcon = import ./users/gponcon/home-lite.nix;
          }
      ];
    };

    deploy.nodes.nlt = {
      hostname = "localhost";
      profiles.system = {
        user = "root";
        path = inputs.deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.nlt;
      };
    };

    deploy.nodes.test = {
      hostname = "test";
      profiles.system = {
        user = "root";
        sshUser = "root";
        remoteBuild = false;
        path = inputs.deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.test;
      };
    };

    checks = builtins.mapAttrs (system: deployLib: deployLib.deployChecks self.deploy) inputs.deploy-rs.lib;

# NE FONCTIONNE PAS POUR LE MOMENT
#
#    colmenaHive = colmena.lib.makeHive self.outputs.colmena;
#
#    # https://github.com/zhaofengli/colmena/issues/60#issuecomment-1510496861
#    colmena = let conf = self.nixosConfigurations; in {
#      meta = {
#        description = "Mes hosts";
#        nixpkgs = import nixpkgs {
#          system = "x86_64-linux";
#          #stateVersion = "25.05";
#          allowUnfree = true;
#        };
#        nodeNixpkgs = builtins.mapAttrs (name: value: value.pkgs) conf;
#        nodeSpecialArgs = builtins.mapAttrs (name: value: value._module.specialArgs) conf;
#      } // builtins.mapAttrs (name: value: { imports = value._module.args.modules; }) conf;
#      
#      # Conf déploiement colmena
#      defaults.deployment = {
#        buildOnTarget = nixpkgs.lib.mkDefault false;
#        allowLocalDeployment = nixpkgs.lib.mkDefault false;
#        targetUser = null;
#      };
#
#      # Laptop
#      nlt = {
#        deployment = {
#          tags = [ "desktop" "admin" "local" ];
#          allowLocalDeployment = true;
#          #targetHost = "192.168.1.1";
#          buildOnTarget = true;
#        };
#      };
#
#      # Test vm
#      test = {
#        deployment = {
#          tags = [ "test" "admin" ];
#          allowLocalDeployment = false;
#          #targetHost = "192.168.1.1";
#          #buildOnTarget = true;
#        };
#      };
#
##      rpi = { pkgs, ... }: {
##        nixpkgs.system = "aarch64-linux";
##      };
#    };

  }; # outputs
}
