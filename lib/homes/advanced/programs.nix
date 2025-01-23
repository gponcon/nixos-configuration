# Useful programs for advanced users (computer scientists)

{ pkgs, ... }:
{
  home.packages = with pkgs; [
    bat
    btop
    ccrypt
    duf
    htop
    jq
    lsof
    psmisc # killall, pstree, pslog, fuser...
    pv
    rsync
    strace
    zellij
  ];
}
