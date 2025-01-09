{
  description = "Main NixOS Flake";

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
      hosts = [
        {
          hostname = "nlt";
          users = [ "gponcon" ];
        }
        {
          hostname = "test";
          users = [ "gponcon" ];
        }
      ];
    in
    {
      nixosConfigurations = builtins.listToAttrs (
        map (
          host:
          nixpkgs.lib.nameValuePair host.hostname (
            nixpkgs.lib.nixosSystem {
              system = "x86_64-linux";
              specialArgs = {
                hostname = host.hostname;
              };
              modules = [
                ./modules
                ./local/hosts/${host.hostname}
                home-manager.nixosModules.home-manager
                {
                  home-manager.useGlobalPkgs = true;
                  home-manager.useUserPackages = true;
                  home-manager.users =
                    let
                      users = host.users;
                    in
                    builtins.listToAttrs (
                      map (user: nixpkgs.lib.nameValuePair user (import ./local/users/${user}/home.nix)) users
                    );
                }
              ];
            }
          )
        ) hosts
      );

      # https://github.com/zhaofengli/colmena/issues/60#issuecomment-1510496861
      colmena =
        let
          conf = self.nixosConfigurations;
        in
        {
          meta = {
            description = "Arthur Network";
            nixpkgs = import nixpkgs {
              system = "x86_64-linux";
              #stateVersion = "25.05";
              allowUnfree = true;
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

          # Laptop
          nlt = {
            deployment = {
              tags = [
                "desktop"
                "admin"
                "local"
              ];
              allowLocalDeployment = true;
              buildOnTarget = true;
            };
          };

          # Test vm
          test = {
            deployment = {
              tags = [
                "test"
                "admin"
              ];
              allowLocalDeployment = false;
              targetHost = "test";
              buildOnTarget = false;
            };
          };

          #rpi = { pkgs, ... }: {
          #  nixpkgs.system = "aarch64-linux";
          #};

        }
        // builtins.mapAttrs (_name: value: { imports = value._module.args.modules; }) conf;
    }; # outputs
}
