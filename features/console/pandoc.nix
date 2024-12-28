{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    pandoc
    texliveConTeXt
    perl538Packages.ImageExifTool
  ];
}