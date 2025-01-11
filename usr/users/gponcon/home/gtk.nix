{ pkgs, ... }:
{
  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 22;
  };

  #gtk = {
  #  enable = true;
  #
  #  iconTheme = {
  #    package = pkgs.papirus-icon-theme;
  #    name = "Papirus Dark";
  #  };
  #};
}
