# Graphic environment with office softwares

{
  lib,
  config,
  user,
  ...
}:
let
  cfg = config.darkone.theme.office;
in
{
  options = {
    darkone.theme.office.enable = lib.mkEnableOption "Graphic environment with office softwares";
  };

  config = lib.mkIf cfg.enable {

    # Based on a minimal user
    darkone.theme.minimal.enable = true;

    # Common packages features
    darkone.console.packages.enable = lib.mkDefault true;
    darkone.graphic.packages.enable = lib.mkDefault true;

  };
}
