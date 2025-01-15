# Features for teenagers

{
  lib,
  config,
  ...
}:
let
  cfg = config.darkone.user.teenager;
in
{
  options = {
    darkone.user.teenager.enable = lib.mkEnableOption "Teenager profile";
  };

  config = lib.mkIf cfg.enable {

    # Based on a minimal user
    darkone.user.minimal.enable = true;

    # Additional features for teens
    darkone.graphic.education.enable = lib.mkDefault true;
    darkone.graphic.education.enableTeenager = lib.mkDefault true;
    darkone.graphic.education.enableGames = lib.mkDefault true;

  };
}
