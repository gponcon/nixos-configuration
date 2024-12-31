{
  description = "Main NixOS Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    
    # Utilisation de home manager comme module flake
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
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

  };
}
