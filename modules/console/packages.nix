{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.darkone.console.packages;
in
{
  options = {
    darkone.console.packages.enable = lib.mkEnableOption "Useful base packages";
    darkone.console.packages.enableAdditional = lib.mkEnableOption "Useful additional packages";
  };

  config.environment = lib.mkIf cfg.enable {
    systemPackages =
      with pkgs;
      [
        vim
        less
      ]
      ++ (
        if cfg.enableAdditional then
          [
            fzf
            git
            htop
            neofetch
            tree
            wget
          ]
        else
          [ ]
      );
    variables.EDITOR = "vim";
  };

}
