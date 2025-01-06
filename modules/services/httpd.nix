{
  lib,
  config,
  ...
}:
let
  cfg = config.darkone.services.httpd;
in
{
  options = {
    darkone.graphic.services.httpd = lib.mkEnableOption "Enable httpd (apache)";
  };

  config = lib.mkIf cfg.enable {

    # Apache
    services.httpd = {
      enable = true;
      enablePHP = true;
      adminAddr = "gponcon@sn-pm.lan";
      virtualHosts.localhost.documentRoot = "/var/www";
      virtualHosts.localhost.enableUserDir = true;
      extraConfig = ''
        <Directory "/var/www">
          DirectoryIndex index.php index.htm index.html
            Allow from *
            Options FollowSymLinks
            AllowOverride All
        </Directory>
      '';
    };
  };
}
