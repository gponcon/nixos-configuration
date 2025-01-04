{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.darkone.nix-builder;
in
{
  options = {
    darkone.nix-builder.enable = lib.mkEnableOption "Enable NIX configuration builder tools";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      colmena
      nixfmt-rfc-style
      deadnix
    ];
  };
}
