{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ colmena nixfmt deadnix ];
}
