# Darkone Network administrator (super-admin)

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
    darkone.user.nix-admin.enable = lib.mkEnableOption "Darkone Network administrator (super-admin)";
  };

  config = lib.mkIf cfg.enable {

    # Based on admin user
    darkone.user.admin.enable = lib.mkForce true;

    # Nix features
    darkone.admin.nix.enable = lib.mkDefault true;

  };
}
