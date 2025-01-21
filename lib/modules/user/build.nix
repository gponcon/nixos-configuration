{
  lib,
  config,
  host,
  pkgs,
  ...
}:
let
  mkUser = user: {
    name = user.login;
    value = {
      isNormalUser = true;
      inherit (user) uid;
      description = "${user.name}";
    } // import ./../../../${user.profile}.nix { inherit pkgs lib config; };
  };
  cfg = config.darkone.user.build;
in
{
  options = {
    darkone.user.build.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Users common builder (enabled by default)";
    };
  };

  config = lib.mkIf cfg.enable { users.users = builtins.listToAttrs (map mkUser host.users); };
}
