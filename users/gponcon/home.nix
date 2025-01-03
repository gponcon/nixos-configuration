# Chargé par le flake dans la section home-manager

{ ... }: {
  home.username = "gponcon";
  home.homeDirectory = "/home/gponcon";

  imports = [
    ./home/git.nix
    ./home/programs.nix
    ./home/vim.nix
    #./home/gtk.nix
  ];

  # Déjà dans la conf globale, à étudier
  #programs.zsh = {
  #  enable = true;
  #  enableCompletion = true;
  #  autosuggestion.enable = true;
  #  syntaxHighlighting.enable = true;
  #  shellAliases = {
  #    ll = "ls -l";
  #    update = "sudo nixos-rebuild switch";
  #  };
  #  history.size = 10000;
  #  promptInit = "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
  #  shellInit = ''
  #    export MANPAGER="less -M -R -i --use-color -Dd+R -Du+B -DHkC -j5";
  #  '';
  #};

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
