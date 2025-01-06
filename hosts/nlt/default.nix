{
  imports = [
    ./../common.nix
    ./../../users
  ];

  # Darkone modules
  darkone = {

    # Host type
    host.laptop.enable = true;

    # Hardware & System
    system = {
      documentation.enable = true;
    };

    # System admin
    admin = {
      nix.enable = true;
      nix.enableNh = false;
    };

    # Daemons
    services = {
      audio.enable = true;
      httpd.enable = true;
      printing.enable = true;
      printing.loadAll = false;
      printing.enableHpPrinters = true;
    };

    # Console applications
    console = {
      git.enable = true;
      packages.enable = true;
      packages.enableAdditional = true;
      pandoc.enable = true;
      zsh.enable = true;
    };

    # Graphical applications
    graphic = {
      gnome.enable = true;
      packages.enable = true;
      packages.enableEmail = false;
      virt-manager.enable = true;
    };
  };

  system.stateVersion = "24.05";
}
