{ lib, config, ... }:
let cfg = config.darkone.ssd;
in {
  options = {
    darkone.ssd.enable = lib.mkEnableOption "Enable SSD optimisation";
  };

  # Optimisation SSD
  config = lib.mkIf cfg.enable {
    services.fstrim.enable = true;
    services.fstrim.interval = "daily";
  };
}
