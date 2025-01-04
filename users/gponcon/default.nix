# Chargé par la conf globale
# Pour définir le user gponcon

{ pkgs, ... }:
{
  users.users.gponcon = {
    isNormalUser = true;
    description = "gponcon";
    extraGroups = [
      "networkmanager"
      "wheel"
      "corectrl"
    ];
    shell = pkgs.zsh;
  };
}
