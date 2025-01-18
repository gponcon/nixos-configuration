# Non-nix admin user profile

{ pkgs, ... }:
{
  extraGroups = [
    "networkmanager"
    "wheel"
    "corectrl"
  ];
}
// import ./advanced.nix { inherit pkgs; }
