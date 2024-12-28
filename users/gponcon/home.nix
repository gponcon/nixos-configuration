# Chargé par le flake dans la section home-manager

{ config, lib, pkgs, ...}:
{
  home.username = "gponcon";
  home.homeDirectory = "/home/gponcon";
  home.packages = with pkgs; [

    # Bureautique graphique
    libreoffice
    obsidian
    hunspell
    hunspellDicts.fr-moderne
    #thunderbird
    #gv
    #ghostscript

    # Outils CLI
    presenterm
    asciidoc-full
    asciidoctor
    aspellDicts.fr
    ranger

    # Développement, administration
    vscode
    zellij
    python3Full
    ccrypt
    btop
    duf
    bat
    gparted
    findutils # locate

    # Réseau
    nmap
    filezilla
    #nettools

    # Outils Bac Pro
    klavaro
    fritzing
    ngspice # Simulateur elec
    qucs-s # Schéma elec + simulation

    # Productivité, multimédia
    inkscape
    geeqie
    gimp
    evince
  ];

  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 1800;
    enableSshSupport = true;
  };

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
