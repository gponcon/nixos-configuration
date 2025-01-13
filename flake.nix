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
        system = system;
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

                # Use global packages from nixpkgs
                useGlobalPkgs = true;

                # Install in /etc/profiles instead of ~/nix-profiles.
                useUserPackages = true;
                users = nixpkgs.lib.genAttrs host.users (user: import ./usr/users/${user.profile}/home.nix);
                extraSpecialArgs = {
                  hostname = host.hostname;
                  user = user;

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

          # TODO: not working, use "just install" instead
          #// {
          #sshOptions = [
          #  "-i"
          #  "/etc/nixos/var/security/ssh/id_ed25519_nix"
          #];
          #};

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

      ## A single nixos config outputting multiple formats.
      ## Alternatively put this in a configuration.nix.
      #nixosModules.myFormats =
      #  { config, ... }:
      #  {
      #    imports = [
      #      nixos-generators.nixosModules.all-formats
      #    ];
      #  };

      ## a machine consuming the module
      #nixosConfigurations.start-img = nixpkgs.lib.nixosSystem {
      #  modules = [
      #    {
      #      # Pin nixpkgs to the flake input, so that the packages installed
      #      # come from the flake inputs.nixpkgs.url.
      #      nix.registry.nixpkgs.flake = nixpkgs;
      #      # set disk size to to 20G
      #      virtualisation.diskSize = 20 * 1024;
      #    }
      #    ./lib/modules
      #    ./lib/hosts/start-img.nix
      #    self.nixosModules.myFormats
      #  ];
      #};

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
