# Useful programs for advanced users (computer scientists)

{ pkgs, ... }:
{
  home.packages = with pkgs; [
    nmap
    nettools
    tcpdump
    busybox
    iptraf-ng
  ];
}
