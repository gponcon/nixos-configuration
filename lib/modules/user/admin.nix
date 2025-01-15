# Host administrator

{
  lib,
  config,
  user,
  pkgs,
  ...
}:
let
  cfg = config.darkone.user.admin;
in
{
  options = {
    darkone.user.admin.enable = lib.mkEnableOption "Host administrator";
  };

  config = lib.mkIf cfg.enable {

    users.users.${user.login} = {
      extraGroups = [
        "networkmanager"
        "wheel"
        "corectrl"
      ];
      shell = pkgs.zsh;
    };

    # Based on advanced user
    darkone.user.advanced.enable = lib.mkForce true;

  };
}
