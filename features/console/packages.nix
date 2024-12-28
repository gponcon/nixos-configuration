{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    vim
    wget
    neofetch
    tree
    git
    htop
    man-pages
    man-pages-posix
    less
  ];
}