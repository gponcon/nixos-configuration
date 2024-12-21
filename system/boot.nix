{
  # La ramdisk n'est pas compatible avec XEN
  # NOTE: ne fonctionne pas -> erreur avec un attribut initialRamdisk obscure
  #boot.initrd.enable = false;

  # Bootloader
  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    tmp.cleanOnBoot = true;

    # PB de gestion de l'énergie avec le noyau Zen (souffle tt le temps)
    #kernelPackages = pkgs.linuxPackages_zen;
  };
}