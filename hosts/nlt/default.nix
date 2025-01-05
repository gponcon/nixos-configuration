{
  imports = [
    ./../common.nix
    ./../../features
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
    };

    # Console
    console = {
      git.enable = true;
      nh.enable = true;
      packages.enable = true;
      packages.enableAdditional = true;
      pandoc.enable = true;
      zsh.enable = true;
    };
  };

  system.stateVersion = "24.05";
}
