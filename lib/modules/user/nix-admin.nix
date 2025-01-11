# Darkone Network administrator

{
  lib,
  config,
  ...
}:
let
  cfg = config.darkone.user.nix-admin;
in
{
  options = {
    darkone.user.nix-admin.enable = lib.mkEnableOption "Darkone Network administrator";
  };

  config = lib.mkIf cfg.enable {

    # Based on advanced user
    darkone.user.advanced.enable = lib.mkForce true;

    # Nix features
    darkone.admin.nix.enable = lib.mkDefault true;

  };
}
