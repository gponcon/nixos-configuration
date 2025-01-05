{ hostname, ... }:
{
  imports = [
    # Include the results of the hardware scan.
    ./${hostname}/hardware-configuration.nix
    ./../modules
  ];

  # Darkone modules
  darkone = {

    # Hardware & System
    system = {
      core.enable = true; # (default)
      i18n.enable = true;
      i18n.timeZone = "America/Miquelon";
    };
  };
}
