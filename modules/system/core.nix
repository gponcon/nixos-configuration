{
  lib,
  config,
  hostname,
  ...
}:
let
  cfg = config.darkone.system.core;
in
{
  options = {
    darkone.system.core.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Darkone framework core system (activated by default)";
    };
    darkone.system.core.enableFstrim = lib.mkOption {
      type = lib.types.bool;
      default = true;
      example = false;
      description = "SSD optimisation with fstrim";
    };
    darkone.system.core.enableFirewall = lib.mkOption {
      type = lib.types.bool;
      default = true;
      example = false;
      description = "Enable firewall (default true)";
    };
    darkone.system.core.enableBoost = lib.mkOption {
      type = lib.types.bool;
      default = false;
      example = true;
      description = "Enable overclocking, corectl";
    };
  };

  # Useful man & nix documentation
  config = lib.mkIf cfg.enable {

    # Bootloader
    boot = {
      loader.systemd-boot.enable = true;
      loader.efi.canTouchEfiVariables = true;
    };

    # Hostname and firewall
    networking.hostName = hostname;
    networking.firewall = {
      enable = cfg.enableFirewall;
      allowedTCPPorts = [ 22 ];
      allowedUDPPorts = [ ];
    };

    # Overclocking & performance optimisations (WIP)
    programs.corectrl = lib.mkIf cfg.enableBoost {
      enable = true;
      gpuOverclock.enable = true;
    };

    # Enable performance mode and more boot power
    powerManagement = lib.mkIf cfg.enableBoost {
      cpuFreqGovernor = "performance";
      powertop.enable = true;
    };

    # SSD optimisations
    services.fstrim = lib.mkIf cfg.enableFstrim {
      enable = true;
      interval = "daily";
    };

    # Installe les paquetages dans /etc/profiles plutôt que
    # dans $HOME/.nix-profile (comportement par défaut)
    home-manager.useUserPackages = true;

    # On utilise l'instance pkgs globale avec les options nixpkgs
    # au niveau système, plutôt qu'une instance privée, qu'on
    # pourrait configurer dans home-manager.users.<name>.nixpkgs
    home-manager.useGlobalPkgs = true;
  };
}
