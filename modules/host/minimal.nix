{ lib, config, ... }:
let
  cfg = config.darkone.host.minimal;
in
{
  options = {
    darkone.host.minimal.enable = lib.mkEnableOption "Minimal host configuration";
  };

  config = lib.mkIf cfg.enable {

    # Darkone main modules
    darkone.system = {
      core.enable = lib.mkDefault true;
      i18n.enable = lib.mkDefault true;
    };
    darkone.console.packages.enable = lib.mkDefault true;
  };
}
