{ ... }:
{
  # La ramdisk n'est pas compatible avec XEN
  # NOTE: ne fonctionne pas -> erreur avec un attribut initialRamdisk obscure
  #boot.initrd.enable = false;

  # Bootloader
  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;

    # Problèmes matériels avec ça (souris qui s'éteint...)
    #tmp.cleanOnBoot = true;
    #kernelPackages = pkgs.linuxPackages_zen;
  };
}
