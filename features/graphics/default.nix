{
  imports = [
    ./gnome.nix
    ./fonts.nix
    ./packages.nix
    ./virt-manager.nix
  ];

  # Enable touchpad support (enabled default in most desktopManager).
  #services.xserver.libinput.enable = true;
}
