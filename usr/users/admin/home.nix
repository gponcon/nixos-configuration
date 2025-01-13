# Chargé par le flake dans la section home-manager

{ user, ... }:
{
  home.username = "${user.login}";
  home.homeDirectory = "/home/${user.login}";

  imports = [
    ./home/git.nix
    ./home/programs.nix
    ./home/vim.nix
    #./home/gtk.nix
  ];

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "25.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
