{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    deploy-rs
  ];
}
