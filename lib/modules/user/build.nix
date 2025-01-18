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
      description = "${user.name}";

      # To load with the right profile
      shell = pkgs.zsh;
      extraGroups = [
        "networkmanager"
        "wheel"
        "corectrl"
      ];
    }; # NOT WORKING # // (import ./../../../${user.profile}.nix { inherit pkgs; });
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
