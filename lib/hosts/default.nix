# Hosts directories dispatcher

{ user, ... }:
let
  hostLocation = (if builtins.pathExists ./../../usr/hosts/${user.profile}.nix then "usr" else "lib");
in
{
  import [
    ./../../${hostLocation}/hosts/${user.profile}.nix
  ];
}
