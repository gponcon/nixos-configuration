# Start image for new nodes (used by main flake)

{
  lib,
  imgFormat,
  ...
}:
{
  darkone.host =
    if imgFormat == "vbox" then
      {
        vm.enableVirtualbox = true;
      }
    else if imgFormat == "xen" then
      {
        vm.enableXen = true;
      }
    else
      {
        # Based on minimal configuration by default
        minimal.enable = lib.mkDefault true;
      };

  users.users.root.initialPassword = "ToChange";

  # hardware configuration from real machine

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

  # fileSystems."/" = {
  #   device = "/dev/disk/by-uuid/91c7f80a-4fe0-4e9c-af30-ab24c041d952";
  #   fsType = "ext4";
  # };

  # fileSystems."/boot" = {
  #   device = "/dev/disk/by-uuid/C0BD-DA90";
  #   fsType = "vfat";
  #   options = [
  #     "fmask=0077"
  #     "dmask=0077"
  #   ];
  # };

  # swapDevices = [
  #   { device = "/dev/sda2"; }
  # ];

  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  system.stateVersion = "25.05";
}
