{ config, lib, pkgs, ... }:
{
  # Pas de mot de passe pour sudo / groupe wheel
  security.sudo.wheelNeedsPassword = false;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.gponcon = {
    isNormalUser = true;
    description = "gponcon";
    extraGroups = [ "networkmanager" "wheel" "corectrl" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      #thunderbird
      libreoffice
      vscode
      obsidian
      zsh
      zsh-powerlevel10k
      zsh-forgit
      zsh-fzf-tab
      zellij
      pandoc
      presenterm
      nmap
      nettools
      klavaro
      inkscape
      geeqie
      gimp
      filezilla
      duf
      evince
      ccrypt
      btop
      asciidoc-full
      asciidoctor
      aspellDicts.fr
      hunspell
      hunspellDicts.fr-moderne
      bat
      gparted
      less
      fritzing
      ngspice # Simulateur elec
      qucs-s # Schéma elec + simulation
      ranger
      #gv
      #ghostscript
      findutils # locate
    ];
  };
}