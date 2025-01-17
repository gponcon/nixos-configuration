{
  lib,
  config,
  host,
  ...
}:
let
  mkUser = user: {
    name = user.login;
    value = {
      isNormalUser = true;
      description = "${user.name}";
    } // import ./../../../lib/homes/nix-admin.nix;
    #} // import ./../../../${user.profile}.nix;
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
