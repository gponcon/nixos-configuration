# Useful programs for network / sysadmin users

{ pkgs, ... }:
{
  # NOTE: do NOT install busybox (incompatible readlink with nix build)
  home.packages = with pkgs; [
    bridge-utils
    inetutils
    iptraf-ng
    nettools
    nmap
    ntp
    ntpstat
    tcpdump
  ];
}
