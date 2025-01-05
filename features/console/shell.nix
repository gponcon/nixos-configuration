{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    zsh
    zsh-powerlevel10k
    zsh-forgit
    zsh-fzf-tab
  ];

  # ZSH
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      ll = "ls -l";
      vz = "vim `fzf`";
      nx = "cd /etc/nixos";
      nf = "nixfmt";
      nd = "deadnix";
      update = "sudo nixos-rebuild switch";
    };
    promptInit = "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
    shellInit = ''
      export MANPAGER="less -M -R -i --use-color -Dd+R -Du+B -DHkC -j5";
    '';
  };
}
