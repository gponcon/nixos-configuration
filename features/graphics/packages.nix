{ pkgs, ... }:
{
  # TODO
  environment.systemPackages = with pkgs; [ ];
  programs.firefox.enable = true;
}
