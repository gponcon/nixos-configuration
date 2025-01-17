{
  darkone.host.minimal.enable = true;

  # Darkone minimal modules
  # TODO: put timezone in the configuration
  darkone = {

    # Hardware & System
    system = {
      core.enable = true; # (default)
      i18n.enable = true;
      i18n.timeZone = "America/Miquelon";
    };
  };
}
