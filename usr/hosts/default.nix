{ host, ... }:
{
  imports = [
    ./${host.profile}.nix
  ];
}
