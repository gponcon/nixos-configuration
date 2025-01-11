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

  };

  system.stateVersion = "24.05";
}
