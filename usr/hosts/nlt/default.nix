{
  imports = [
    ./../common.nix
    ./../../users/darkone
  ];

  # Darkone modules
  darkone = {

    # Host type
    host.laptop.enable = true;

    # Profile
    user.nix-admin.enable = true;

    # Hp printers
    service.printing.enableHpPrinters = true;

    # No email software
    graphic.packages.enableEmail = false;

    # Virtualbox (to put in a profile)
    graphic.virtualbox.enable = true;

    # I'm the master, not a node
    host.isNode = false;

  };

  system.stateVersion = "24.05";
}
