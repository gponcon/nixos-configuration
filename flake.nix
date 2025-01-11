{
  description = "Darkone Framework";

  # Usefull cache for colmena
  nixConfig = {
    extra-trusted-substituters = [
      "https://cache.garnix.io"
      "https://nix-community.cachix.org"
    ];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    colmena.url = "github:zhaofengli/colmena";
    colmena.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      colmena,
      ...
    }:

    let
      system = "x86_64-linux";

      # The hosts.nix generated file (just generate)
      hosts = import ./var/generated/hosts.nix;

      mkNixosHost = host: {
        name = host.hostname;
        value = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            hostname = host.hostname;
          };
          modules = [
            ./lib/modules
            ./usr/hosts/${host.hostname}
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users = nixpkgs.lib.genAttrs host.users (user: import ./usr/users/${user}/home.nix);
                extraSpecialArgs = {
                  hostname = host.hostname;

                  # This hack must be set to allow unfree packages
                  # in home manager configurations.
                  # useGlobalPkgs with allowUnfree nixpkgs do not works.
                  pkgs = import nixpkgs {
                    inherit system;
                    config.allowUnfree = true;
                  };
                };
              };
            }
          ];
        };
      };

      mkColmenaHost = host: {
        name = host.hostname;
        value = {
          deployment = host.deployment;
        };
      };

    in
    {
      nixosConfigurations = builtins.listToAttrs (map mkNixosHost hosts);

      nixpkgs = {
        config = {
          allowUnfree = true;
          allowUnfreePredicate = (_: true);
        };
      };

      # https://github.com/zhaofengli/colmena/issues/60#issuecomment-1510496861
      colmena =
        let
          conf = self.nixosConfigurations;
        in
        {
          meta = {
            description = "Darkone Framework Network";
            nixpkgs = import nixpkgs {
              system = "x86_64-linux";
              allowUnfree = true;
              allowUnfreePredicate = (_: true);
              overlays = [ ];
            };
            nodeNixpkgs = builtins.mapAttrs (_name: value: value.pkgs) conf;
            nodeSpecialArgs = builtins.mapAttrs (_name: value: value._module.specialArgs) conf;
          };

          # Conf déploiement colmena
          defaults.deployment = {
            buildOnTarget = nixpkgs.lib.mkDefault false;
            allowLocalDeployment = nixpkgs.lib.mkDefault false;
            targetUser = null;
          };

        }
        // builtins.listToAttrs (map mkColmenaHost hosts)
        // builtins.mapAttrs (_name: value: { imports = value._module.args.modules; }) conf;

    }; # outputs
}
