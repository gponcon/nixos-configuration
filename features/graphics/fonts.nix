{ pkgs, ... }: {
  fonts.packages = with pkgs; [
    gentium
    meslo-lgs-nf
    nerd-fonts.jetbrains-mono
    #(nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];
  fonts.fontconfig.enable = true;
}
