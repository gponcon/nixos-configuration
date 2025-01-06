# NixOS configuration for the LAN administrator

{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.darkone.admin.nix;
in
{
  options = {
    darkone.admin.nix.enable = lib.mkEnableOption "Enable NIX configuration builder tools";
  };

  config = lib.mkIf cfg.enable {

    # Nix / Darkone management packages
    environment.systemPackages = with pkgs; [
      colmena
      deadnix
      gnumake
      nixfmt-rfc-style
    ];

    # Optimized switch (perl -> rust)
    system.switch = {
      enable = false;
      enableNg = true;
    };

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    # Utilisation de la commande nix et des flakes
    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];

    # On fait confiance à une machine distante pour lui envoyer une conf
    nix.settings.trusted-users = [
      "root"
      "@wheel"
    ];

  };
}
