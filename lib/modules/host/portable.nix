{
  lib,
  config,
  ...
}:
let
  cfg = config.darkone.host.portable;
in
{
  options = {
    darkone.host.portable.enable = lib.mkEnableOption "Portable host configuration for usb keys";
  };

  config = lib.mkIf cfg.enable {

    # Based on laptop configuration
    darkone.host.laptop.enable = true;

    # System additional features
    darkone.system = {
    };

    # Daemons
    darkone.services = {
      printing.loadAll = lib.mkDefault true;
    };
  };
}
