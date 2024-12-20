# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      #./forgejo.nix
    ];
  
  # La ramdisk n'est pas compatible avec XEN
  # NOTE: ne fonctionne pas -> erreur avec un attribut initialRamdisk obscure
  #boot.initrd.enable = false;

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 ];
    allowedUDPPorts = [];
  };
  #networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Miquelon";

  # Select internationalisation properties.
  i18n.defaultLocale = "fr_FR.UTF-8";

  # Optimisation SSD
  services.fstrim.enable = true;  

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Suppression des paquets gnome inutiles
  environment.gnome.excludePackages = with pkgs; [
    geary
    gnome-backgrounds
    gnome-tour
    gnome-user-docs
    epiphany
    gnome-calendar
    gnome-clocks
    gnome-contacts
    gnome-logs
    gnome-maps
    gnome-music
    gnome-weather
    loupe
    simple-scan
    totem
    yelp
    gnome-software
  ];

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "fr";
    variant = "azerty";
  };

  # Configure console keymap
  console.keyMap = "fr";

  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.printing.drivers = [ pkgs.hplip pkgs.hplipWithPlugin ];
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Pas de mot de passe pour sudo / groupe wheel
  # https://discourse.nixos.org/t/dont-prompt-a-user-for-the-sudo-password/9163
  security.sudo.wheelNeedsPassword = false;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.gponcon = {
    isNormalUser = true;
    description = "gponcon";
    extraGroups = [ "networkmanager" "wheel" "corectrl" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      thunderbird
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
      bat
      gparted
      less
      fritzing
      ngspice # Simulateur elec
      qucs-s # Schéma elec + simulation
      ranger
      #gv
      #ghostscript
    ];
  };

  fonts.packages = with pkgs; [
    gentium
    meslo-lgs-nf
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];
  fonts.fontconfig.enable = true;

  # Personnalisation de gnome
  programs.dconf = {
    enable = true;
    profiles.user.databases = [
      {
        lockAll = true; # prevents overriding
        settings = {
          "org/gnome/desktop/interface" = {
            color-scheme = "prefer-dark";
            monospace-font-name = "JetBrainsMono NF";
            enable-hot-corners = false;
          };
          "org/gnome/desktop/background" = {
            picture-uri-dark = "file:///nix/store/ipcpsgpsam4y3d6krciwri59q1ghxq2k-simple-blue-2016-02-19/share/backgrounds/nixos/nix-wallpaper-simple-blue.png";
          };
          "org/gnome/desktop/wm/keybindings" = {
            switch-applications = [ "<Super>Tab" ];
            switch-applications-backward = [ "<Shift><Super>Tab" ];
            switch-windows = [ "<Alt>Tab" ];
            switch-windows-backward = [ "<Shift><Alt>Tab" ];
          };
        };
      }
    ];
  };

  # ZSH
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      ll = "ls -l";
      update = "sudo nixos-rebuild switch";
    };
    promptInit = "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
    shellInit = ''
      export MANPAGER="less -M -R -i --use-color -Dd+R -Du+B -DHkC -j5";
    '';
  };

  # Git
  programs.git.enable = true;

  # Install firefox.
  programs.firefox.enable = true;

  # Overclocking
  programs.corectrl.enable = true;
  programs.corectrl.gpuOverclock.enable = true;
  

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    neofetch
    #sqlite # forgejo
    #forgejo-cli
    python3Full
    tree
    git
    gnumake
    texliveConTeXt
    perl538Packages.ImageExifTool
    hplip
    htop
    man-pages
    man-pages-posix
  ];

  # Pages de manuel
  documentation = {
    enable = true;

    man = {
      enable = true;
      man-db.enable = false;
      mandoc.enable = true;
      generateCaches = true;
    };
  };

  # Virtualisation XEN
  # NOTE: ne fonctionne pas -> Xen does not support the legacy script-based Stage 1 initrd
  #virtualisation.xen.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Apache
  services.httpd = {
    enable = true;
    enablePHP = true;
    adminAddr = "gponcon@sn-pm.lan";
    virtualHosts.localhost.documentRoot = "/var/www";
    virtualHosts.localhost.enableUserDir = true;
    extraConfig = 
    ''
    <Directory "/var/www">
    	DirectoryIndex index.php index.htm index.html
      	Allow from *
        Options FollowSymLinks
        AllowOverride All
    </Directory>
    ''; 
  };

  # Utilisation de la commande nix et des flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];    

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
