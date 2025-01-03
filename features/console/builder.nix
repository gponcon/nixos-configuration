{ pkgs, ... }:

{
  # Ne fonctionne pas car pas la même version
  # et l'overlay ne fonctionne pas non plus
  # Obligé d'utiliser ça pour que colmena fonctionne :
  # nix shell github:zhaofengli/colmena
  environment.systemPackages = with pkgs; [
    colmena
  ];
}
