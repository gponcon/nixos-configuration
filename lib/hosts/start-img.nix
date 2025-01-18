# Start image for new nodes (used by main flake)

{ lib, imgFormat, ... }:
{
  darkone.host =
    if imgFormat == "vbox" then
      { vm.enableVirtualbox = true; }
    else if imgFormat == "xen" then
      { vm.enableXen = true; }
    else
      {
        # Based on minimal configuration by default
        minimal.enable = lib.mkDefault true;
      };

  users.users.root.initialPassword = "ToChange";

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

  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  system.stateVersion = "25.05";
}
