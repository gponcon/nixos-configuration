# Homes directories dispatcher

{ user, ... }:
let
  homeLocation = (if builtins.pathExists ./../../usr/homes/${user.profile}.nix then "usr" else "lib");
in
{
  import [
    ./../../${homeLocation}/homes/${user.profile}.nix
  ];
}
