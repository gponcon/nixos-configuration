{ config, lib, pkgs, ...}:
{
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
