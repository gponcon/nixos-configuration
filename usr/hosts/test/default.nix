{
  imports = [
    ./../common.nix
    ./../../users/darkone
  ];

  # Darkone modules
  darkone = {

    # Host type
    host.server.enable = true;

    # Hardware & System
    system = {
      documentation.enable = true;
    };

    # Console applications
    console = {
      git.enable = true;
      packages.enable = true;
      zsh.enable = true;
    };

    # Graphical applications
    #graphic = {
    #  gnome.enable = true;
    #  packages.enable = true;
    #};
  };

  system.stateVersion = "24.05";
}
