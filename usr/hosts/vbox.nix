# VBOX virtual machine profile

{
  imports = [
    ./common.nix
  ];

  # Darkone modules
  darkone = {

    # Virtualbox VM
    host.vm.enableVirtualbox = true;

    # For advanced user
    user.advanced.enable = true;
  };

  system.stateVersion = "24.05";
}
