{ user, ... }:
{
  # Home manager minimal settings
  #home.username = "${user.login}";
  #home.homeDirectory = "/home/${user.login}";

  # Is a minimal real user
  #darkone.user.minimal.enable = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Darkone minimal modules
  # TODO: put timezone in the configuration
  #darkone = {

  #  # Hardware & System
  #  system = {
  #    core.enable = true; # (default)
  #    i18n.enable = true;
  #    i18n.timeZone = "America/Miquelon";
  #  };
  #};

  home.stateVersion = "25.05";
}
