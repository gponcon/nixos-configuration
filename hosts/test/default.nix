{
  imports = [
    ./../common.nix
    ./../../features/services/ssh.nix
    ./../../features/graphics/fonts.nix
    ./../../features/graphics/gnome.nix
    ./../../users/gponcon
  ];

  system.stateVersion = "24.05";
}
