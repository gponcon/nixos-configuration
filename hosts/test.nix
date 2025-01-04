# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  imports = [
    # Include the results of the hardware scan.
    ./test/hardware.nix
    ./../system/settings.nix
    ./../system/boot.nix
    ./../system/home-manager.nix
    ./../system/i18n.nix
    ./../system/network.nix
    ./../system/performance.nix
    ./../system/security.nix
    ./../features/services/ssh.nix
    ./../features/console/packages.nix
    ./../features/console/console.nix
    ./../features/console/shell.nix
    ./../features/graphics/fonts.nix
    ./../features/graphics/gnome.nix
    ./../users/gponcon
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
