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
    environment.systemPackages = with pkgs; [
      colmena
      deadnix
      gnumake
      nixfmt-rfc-style
    ];
  };
}
