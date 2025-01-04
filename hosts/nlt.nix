# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  imports = [
    # Include the results of the hardware scan.
    ./nlt/hardware-configuration.nix
    ./../modules
    ./../system
    ./../features
    ./../users
  ];

  # Darkone modules
  darkone = {

    # Hardware & System
    system = {
      ssd-optims.enable = true;
      documentation.enable = true;
    };

    # System admin
    admin = {
      nix.enable = true;
    };
  };

  system.stateVersion = "24.05"; # Did you read the comment?
}
