{
  lib,
  pkgs,
  config,
  ...
}:
let
  cfg = config.darkone.host.laptop;
in
{
  options = {
    darkone.host.laptop.enable = lib.mkEnableOption "Laptop optimized host configuration";
  };

  config = lib.mkIf cfg.enable {

    # Based on desktop configuration
    darkone.host.desktop.enable = lib.mkForce true;

    # Several printing drivers
    darkone.service.printing.loadAll = lib.mkDefault false;

    # Sensors management (WIP)
    boot.kernelModules = [ "coretemp" ];
    environment.systemPackages = with pkgs; [ lm_sensors ];

    # WIP
    #hardware.fancontrol.enable = true;

    services.thermald.enable = true;
  };
}
