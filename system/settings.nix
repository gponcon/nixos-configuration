{
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Utilisation de la commande nix et des flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # On fait confiance à une machine distante pour lui envoyer une conf
  nix.settings.trusted-users = [ "@wheel" ];  
}
