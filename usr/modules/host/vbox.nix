# VBOX virtual machine profile

{ lib, config, ... }:
let
  cfg = config.darkone.host.vbox;
in
{
  options = {
    darkone.host.vbox.enable = lib.mkEnableOption "A personalized virtualbox config";
  };

  config = lib.mkIf cfg.enable {

    # Darkone modules
    darkone = {

      # Virtualbox VM
      host.vm.enableVirtualbox = true;

      # For advanced users
      theme.advanced.enable = true;
    };

    # Virtualbox hardware specific configuration
    # TODO: make generic
    boot.initrd.availableKernelModules = [
      "ata_piix"
      "ohci_pci"
      "ehci_pci"
      "ahci"
      "sd_mod"
      "sr_mod"
    ];
    boot.initrd.kernelModules = [ ];
    boot.kernelModules = [ ];
    boot.extraModulePackages = [ ];
    fileSystems."/" = {
      device = "/dev/disk/by-uuid/91c7f80a-4fe0-4e9c-af30-ab24c041d952";
      fsType = "ext4";
    };
    fileSystems."/boot" = {
      device = "/dev/disk/by-uuid/C0BD-DA90";
      fsType = "vfat";
      options = [
        "fmask=0077"
        "dmask=0077"
      ];
    };
    swapDevices = [ { device = "/dev/sda2"; } ];
    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

    system.stateVersion = "25.05";
  };
}
