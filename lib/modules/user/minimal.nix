{
  lib,
  config,
  user,
  ...
}:
let
  cfg = config.darkone.user.minimal;
in
{
  options = {
    darkone.user.minimal.enable = lib.mkEnableOption "Minimal user declaration";
  };

  config = lib.mkIf cfg.enable {

    users.users.${user.login} = {
      isNormalUser = true;
      description = "${user.name}";
    };

  };
}
