{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.darkone.console.pandoc;
in
{
  options = {
    darkone.console.pandoc.enable = lib.mkEnableOption "Pre-configured pandoc environment";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      pandoc
      texliveConTeXt
      perl538Packages.ImageExifTool
    ];
  };
}
