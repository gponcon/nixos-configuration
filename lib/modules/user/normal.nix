# Normal user with graphic environment

{
  lib,
  config,
  pkgs,
  user,
  ...
}:
let
  cfg = config.darkone.user.normal;
in
{
  options = {
    darkone.user.normal.enable = lib.mkEnableOption "Normal user with graphic environment";
  };

  config = lib.mkIf cfg.enable {

    # Based on a minimal user
    darkone.user.minimal.enable = true;

    # Common packages features
    darkone.console.packages.enable = lib.mkDefault true;
    darkone.graphic.packages.enable = lib.mkDefault true;

  };
}
