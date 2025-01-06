{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.darkone.graphic.packages;
in
{
  # WIP
  options = {
    darkone.graphic.packages.enable = lib.mkEnableOption "Default useful packages";

    darkone.graphic.packages.enableOffice = lib.mkOption {
      type = lib.types.bool;
      default = true;
      example = false;
      description = "Office packages (libreoffice)";
    };
    darkone.graphic.packages.enableInternet = lib.mkOption {
      type = lib.types.bool;
      default = true;
      example = false;
      description = "Internet packages (firefox)";
    };
    darkone.graphic.packages.enableEmail = lib.mkOption {
      type = lib.types.bool;
      default = true;
      example = false;
      description = "Email management packages (thunderbird)";
    };
  };

  config.environment = lib.mkIf cfg.enable {

    # Packages
    environment.systemPackages =
      with pkgs;
      (
        if cfg.enableOffice then
          [
            libreoffice-fresh
            obsidian
          ]
        else
          [ ]
      );

    # Firefox
    programs.firefox = lib.mkIf cfg.enableInternet { enable = true; };

    # Thunderbird
    programs.thunderbird = lib.mkIf cfg.enableEmail { enable = true; };
  };
}
