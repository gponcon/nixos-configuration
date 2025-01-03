{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    fzf
    git
    htop
    less
    man-pages
    man-pages-posix
    neofetch
    tree
    vim
    wget
  ];

  environment.variables = { EDITOR = "vim"; };
}
