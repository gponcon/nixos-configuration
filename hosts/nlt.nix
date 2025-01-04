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

  # Hardware
  darkone.ssd.enable = true;

  # System admin
  darkone.nix-builder.enable = true;

  system.stateVersion = "24.05"; # Did you read the comment?
}
