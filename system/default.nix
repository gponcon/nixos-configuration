{
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Utilisation de la commande nix et des flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  imports = [
    ./boot.nix
    ./network.nix
    ./i18n.nix
    ./disks.nix
    ./performance.nix
    ./power.nix
    ./documentation.nix
  ];
}
