{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.darkone.services.printing;
  all-users = builtins.attrNames config.users.users;
  normal-users = builtins.filter (user: config.users.users.${user}.isNormalUser == true) all-users;
in
{
  # WIP
  options = {
    darkone.services.printing.enable = lib.mkEnableOption "Default useful packages";

    # Full
    darkone.services.printing.enableFull = lib.mkOption {
      type = lib.types.bool;
      default = false;
      example = true;
      description = "Full printers and scanners";
    };

    # Scanners
    darkone.services.printing.enableScanners = lib.mkOption {
      type = lib.types.bool;
      default = false;
      example = true;
      description = "Enable scanners";
    };

    # HP only
    darkone.services.printing.enableHpPrinters = lib.mkOption {
      type = lib.types.bool;
      default = false;
      example = true;
      description = "HP printers";
    };

    # HP only
    darkone.services.printing.enableManualInstall = lib.mkOption {
      type = lib.types.bool;
      default = false;
      example = true;
      description = "Manual installation";
    };
  };

  config = lib.mkIf cfg.enable {

    # Printing service configuration
    services.printing = {
      enable = true;
      startWhenNeeded = true;
      drivers =
        with pkgs;
        (
          if cfg.enableFull then
            [
              brgenml1cupswrapper
              brgenml1lpr
              brlaser
              cnijfilter2
              epkowa
              gutenprint
              gutenprintBin
              samsung-unified-linux-driver
              splix
            ]
          else
            [ ]
        )
        ++ (
          if cfg.enableFull || cfg.enableHpPrinters then
            [
              hplip
              hplipWithPlugin
            ]
          else
            [ ]
        );
    };

    # To install printers manually
    programs.system-config-printer = mkIf cfg.enableManualInstall {
      enable = true;
    };

    # Enable autodiscovery
    services.avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };

    # Who can print?
    users.groups.lp = {
      members = normal-users;
    };

    # systemd.services.cups-browsed.enable = false;
    hardware.sane = lib.mkIf cfg.enableScanners {
      enable = true;
      extraBackends = with pkgs; [
        hplipWithPlugin
        sane-airscan
        epkowa
        utsushi
      ];
    };
    services.udev.packages = lib.mkIf cfg.enableScanners [
      pkgs.sane-airscan
      pkgs.utsushi
    ];

    # add all users to group scanner and lp
    users.groups.scanner = lib.mkIf cfg.enableScanners {
      members = normal-users;
    };

  };
}
