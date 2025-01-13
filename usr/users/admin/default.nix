# Chargé par la conf globale
# Pour définir le user darkone

{ pkgs, user, ... }:
{
  users.users.${user.login} = {
    isNormalUser = true;
    description = "${user.name}";
    extraGroups = [
      "networkmanager"
      "wheel"
      "corectrl"
    ];
    shell = pkgs.zsh;
  };
}
