{ pkgs, ... }:
{
  fonts.packages = with pkgs; [
    gentium
    meslo-lgs-nf
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];
  fonts.fontconfig.enable = true;
}