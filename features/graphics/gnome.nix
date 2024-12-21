{ config, lib, pkgs, ... }:
{
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "fr";
    variant = "azerty";
  };

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Suppression des paquets gnome inutiles
  environment.gnome.excludePackages = with pkgs; [
    atomix
    epiphany
    geary
    gnome-backgrounds
    gnome-calendar
    gnome-clocks
    gnome-contacts
    gnome-font-viewer
    gnome-logs
    gnome-maps
    gnome-music
    gnome-packagekit
    gnome-software
    gnome-tour
    gnome-user-docs
    gnome-weather
    hitori
    iagno
    loupe
    packagekit
    simple-scan
    tali
    totem
    yelp
    xterm
  ];

  # Gnome packages
  environment.systemPackages = with pkgs; [

    # gnome: theme
    #adw-gtk3
    #graphite-gtk-theme
    #tela-circle-icon-theme

    # gnome: personnalisation
    #gnome-tweaks
    
    # gnome: Extension
    gnomeExtensions.caffeine
    gnomeExtensions.gsconnect
    gnomeExtensions.appindicator
    gnomeExtensions.dash-to-dock
  ];

  # Communication avec les devices
  programs.kdeconnect = {
    enable = true;
    package = pkgs.gnomeExtensions.gsconnect;
  };

  # Personnalisation de gnome
  programs.dconf = {
    enable = true;
    profiles.user.databases = [
      {
        lockAll = true; # prevents overriding
        settings = {
          "org/gnome/desktop/wm/preferences" = {
            button-layout = "appmenu:minimize,maximize,close";
#            theme = "adw-gtk3";
            focus-mode = "click";
            visual-bell = false;
          };
          "org/gnome/desktop/interface" = {
#            cursor-theme = "Adwaita";
#            gtk-theme = "adw-gtk3";
#            icon-theme = "Tela-circle";
            color-scheme = "prefer-dark"; # Dark par défaut
            monospace-font-name = "JetBrainsMono NF"; # Fonte mono par défaut
            enable-hot-corners = false; # Suppression des actions quand le curseur arrive dans un coin
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
          "org/gnome/desktop/peripherals/touchpad" = {
            click-method = "areas";
            tap-to-click = true;
            two-finger-scrolling-enabled = true;
          };
          "org/gnome/desktop/peripherals/keyboard" = {
            numlock-state = true;
          };
          "org/gnome/shell" = {
            disable-user-extensions = false;
            enabled-extensions = [
              "caffeine@patapon.info"
              "gsconnect@andyholmes.github.io"
              "appindicatorsupport@rgcjonas.gmail.com"
              "dash-to-dock@micxgx.gmail.com"
            ];
            favorite-apps = [
              "firefox.desktop"
              "org.gnome.TextEditor.desktop"
              "obsidian.desktop"
              "code.desktop"
              "writer.desktop"
              "calc.desktop"
              "impress.desktop"
              #"thunderbird.desktop"
              "org.gnome.Nautilus.desktop"
            ];
          };
          "org/gnome/shell/extensions/dash-to-dock" = {
            click-action = "minimize-or-overview";
            disable-overview-on-startup = true;
            dock-position = "BOTTOM";
            running-indicator-style = "DOTS";
            isolate-monitor = false;
            multi-monitor = true;
            show-mounts-network = true;
            always-center-icons = true;
            custom-theme-shrink = true;
          };
          "org/gnome/mutter" = {
            check-alive-timeout = lib.gvariant.mkUint32 30000;
            dynamic-workspaces = true;
            edge-tiling = true;
          };
        };
      }
    ];
  };
}