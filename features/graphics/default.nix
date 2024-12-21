{
  imports = [
    ./gnome.nix
    ./fonts.nix
    ./packages.nix
  ];

  programs.firefox.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  #services.xserver.libinput.enable = true;
}