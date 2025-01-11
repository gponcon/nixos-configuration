{
  lib,
  config,
  ...
}:
let
  cfg = config.darkone.host.desktop;
in
{
  options = {
    darkone.host.desktop.enable = lib.mkEnableOption "Desktop optimized host configuration";
  };

  config = lib.mkIf cfg.enable {

    # Load minimal configuration
    darkone.host.minimal.enable = true;

    # System additional features
    darkone.system = {
      core.enableFstrim = lib.mkDefault true;
      core.enableBoost = lib.mkDefault true;
    };

    # Daemons
    darkone.services = {
      audio.enable = lib.mkDefault true;
      printing.enable = lib.mkDefault true;
      printing.loadAll = lib.mkDefault false;
    };

    # Graphical applications
    darkone.graphic = {
      gnome.enable = lib.mkDefault true;
      obsidian.enable = lib.mkDefault true;
      packages.enable = lib.mkDefault true;
      packages.enableEmail = lib.mkDefault true;
    };
  };
}
