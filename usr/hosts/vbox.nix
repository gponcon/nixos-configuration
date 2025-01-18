# VBOX virtual machine profile

{
  imports = [ ./vbox ];

  # Darkone modules
  darkone = {

    # Virtualbox VM
    host.vm.enableVirtualbox = true;

    # For advanced users
    theme.advanced.enable = true;
  };

  system.stateVersion = "25.05";
}
