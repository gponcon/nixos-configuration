# Profile for advanced users (computer scientists, developers, admins)

{
  lib,
  config,
  ...
}:
let
  cfg = config.darkone.user.advanced;
in
{
  options = {
    darkone.user.advanced.enable = lib.mkEnableOption "Advanced user (admin sys, developper)";
  };

  config = lib.mkIf cfg.enable {

    # Based on a minimal user
    darkone.user.minimal.enable = true;

    # System additional features
    darkone.system.documentation.enable = lib.mkDefault true;

    # Console additional features
    darkone.console.git.enable = lib.mkDefault true;
    darkone.console.pandoc.enable = lib.mkDefault false;
    darkone.console.zsh.enable = lib.mkDefault true;
    darkone.console.packages.enable = lib.mkDefault true;
    darkone.console.packages.enableAdditional = lib.mkDefault true;

    # Daemons
    darkone.service.httpd.enable = lib.mkDefault false;

  };
}
