{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    vim
    wget
    neofetch
    tree
    git
    python3Full
    #gnumake
    texliveConTeXt
    perl538Packages.ImageExifTool
    htop
    man-pages
    man-pages-posix
  ];
}