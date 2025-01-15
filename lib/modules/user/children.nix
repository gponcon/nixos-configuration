# Features for childs and babies

{
  lib,
  config,
  ...
}:
let
  cfg = config.darkone.user.children;
in
{
  options = {
    darkone.user.children.enable = lib.mkEnableOption "Children profile";
  };

  config = lib.mkIf cfg.enable {

    # Based on a minimal user
    darkone.user.minimal.enable = true;

    # Additional features for children
    darkone.graphic.education.enable = lib.mkDefault true;
    darkone.graphic.education.enableBaby = lib.mkDefault true;
    darkone.graphic.education.enableGames = lib.mkDefault true;

  };
}
