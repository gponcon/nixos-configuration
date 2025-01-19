{
  description = "NixOS Darkone Framework";

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

    colmena.url = "github:zhaofengli/colmena/main";
    colmena.inputs.nixpkgs.follows = "nixpkgs";

    nixos-generators.url = "github:nix-community/nixos-generators";
    nixos-generators.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      colmena,
      nixos-generators,
      ...
    }:

    let

      # Main system
      system = "x86_64-linux";

      # Start img common configuration
      startImgParams = {
        inherit system;
        modules = [
          {
            # Pin nixpkgs to the flake input, so that the packages installed
            # come from the flake inputs.nixpkgs.url.
            nix.registry.nixpkgs.flake = nixpkgs;

            # set disk size to to 20G
            virtualisation.diskSize = 20 * 1024;
          }
          ./lib/modules
          ./lib/hosts/start-img.nix
        ];
      };

      # The hosts.nix generated file (just generate)
      hosts = import ./var/generated/hosts.nix;

      mkHome = user: {
        name = user.login;
        value = {
          imports = [ (import ./${user.profile}) ];

          # Home profiles loading
          home = {
            username = user.login;
            homeDirectory = nixpkgs.lib.mkForce "/home/${user.login}";
            stateVersion = "25.05";
          };
        };
      };

      mkNixosHost = host: {
        name = host.hostname;
        value = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit host;
            imgFormat = "iso";
          };
          modules =
            [
              ./lib/modules
              ./usr/modules
              home-manager.nixosModules.home-manager
              {
                home-manager = {

                  # Use global packages from nixpkgs
                  useGlobalPkgs = true;

                  # Install in /etc/profiles instead of ~/nix-profiles.
                  useUserPackages = true;

                  # Load users profiles
                  users = builtins.listToAttrs (map mkHome host.users);

                  extraSpecialArgs = {
                    inherit host;

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
            ]
            ++ nixpkgs.lib.optional (builtins.pathExists ./usr/machines/${host.hostname}) ./usr/machines/${host.hostname};
        };
      };

      mkColmenaHost = host: {
        name = host.hostname;
        value = host.colmena;
      };

    in
    {
      nixosConfigurations = builtins.listToAttrs (map mkNixosHost hosts);

      nixpkgs = {
        config = {
          allowUnfree = true;
          allowUnfreePredicate = _: true;
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
              allowUnfreePredicate = _: true;
              overlays = [ ];
            };
            nodeNixpkgs = builtins.mapAttrs (_name: value: value.pkgs) conf;
            nodeSpecialArgs = builtins.mapAttrs (_name: value: value._module.specialArgs) conf;
          };

          # Default deployment settings
          defaults.deployment = {
            buildOnTarget = nixpkgs.lib.mkDefault false;
            allowLocalDeployment = nixpkgs.lib.mkDefault false;
            targetUser = "nix";

            # TODO: not working, use "just install" instead
            # Deployment with the project ssh keys
            #sshOptions = [
            #  "-i"
            #  "/etc/nixos/var/security/ssh/id_ed25519_nix"
            #];

          };

        }
        // builtins.listToAttrs (map mkColmenaHost hosts)
        // builtins.mapAttrs (_name: value: { imports = value._module.args.modules; }) conf;

      # Start images generators
      packages.x86_64-linux = {
        start-img-iso = nixos-generators.nixosGenerate (
          startImgParams
          // {
            format = "iso";
            specialArgs = {
              imgFormat = "iso";
              hostname = "ndf-start-iso";
            };
          }
        );
        start-img-vbox = nixos-generators.nixosGenerate (
          startImgParams
          // {
            format = "virtualbox";
            specialArgs = {
              imgFormat = "vbox";
              hostname = "ndf-start-vbox";
            };
          }
        );
        start-img-qcow = nixos-generators.nixosGenerate startImgParams // {
          format = "qcow";
        };
      };

    }; # outputs
}
