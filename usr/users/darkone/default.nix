# Chargé par la conf globale
# Pour définir le user darkone

{ pkgs, ... }:
{
  users.users.darkone = {
    isNormalUser = true;
    description = "darkone";
    extraGroups = [
      "networkmanager"
      "wheel"
      "corectrl"
    ];
    shell = pkgs.zsh;
  };
}
