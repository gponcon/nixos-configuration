{ user, ... }:
{
  imports = [
    ./${user.profile}.nix
  ];
}
