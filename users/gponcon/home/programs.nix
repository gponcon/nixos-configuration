{ config, lib, pkgs, ...}:
{
  home.packages = with pkgs; [

    # Bureautique graphique
    #ghostscript
    #gv
    #thunderbird
    hunspell
    hunspellDicts.fr-moderne
    libreoffice
    obsidian

    # Outils CLI
    asciidoc-full
    asciidoctor
    aspellDicts.fr
    presenterm
    ranger

    # Développement, administration
    bat
    btop
    ccrypt
    duf
    findutils # locate
    gparted
    python3Full
    vscode
    zellij

    # Réseau
    #nettools
    filezilla
    nmap

    # Outils Bac Pro
    fritzing
    klavaro
    ngspice # Simulateur elec
    qucs-s # Schéma elec + simulation

    # Productivité, multimédia
    evince
    geeqie
    gimp
    inkscape

    # Tweak
    powerline
    powerline-fonts
  ];

  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 1800;
    enableSshSupport = true;
  };
}
