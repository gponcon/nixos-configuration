{
  imports = [ ./admin-laptop ];

  # Darkone modules
  darkone = {

    # Based on laptop framework profile
    host.laptop.enable = true;

    # Enable nix administration module
    admin.nix.enable = true;

    # Hp printers
    service.printing.enableHpPrinters = true;

    # No email software
    graphic.packages.enableEmail = false;

    # Virtualbox
    graphic.virtualbox.enable = true;

    # I'm the master, not a node
    host.isNode = false;
  };

  system.stateVersion = "24.05";
}
