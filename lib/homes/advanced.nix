# Advanced user profile (computer scientists, developers, admins)

{
  pkgs,
  ...
}:
{ shell = pkgs.zsh; } // builtins.import ./minimal.nix
