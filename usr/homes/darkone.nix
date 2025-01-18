# A unique user profile

{
  pkgs,
  lib,
  config,
  ...
}:
import ./../../lib/homes/nix-admin.nix { inherit pkgs lib config; }
