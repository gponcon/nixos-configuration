{
  imports = [
    ./../common.nix
    ./../../users/darkone
  ];

  # Darkone modules
  darkone = {

    # Virtualbox VM
    host.vm.enableVirtualbox = true;

    # For advanced user
    user.advanced.enable = true;

  };

  system.stateVersion = "25.05";
}
