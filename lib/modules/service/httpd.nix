{
  lib,
  config,
  ...
}:
let
  cfg = config.darkone.service.httpd;
in
{
  options = {
    darkone.service.httpd.enable = lib.mkEnableOption "Enable httpd (apache)";
  };

  config = lib.mkIf cfg.enable {

    # Apache
    services.httpd = {
      enable = true;
      enablePHP = true;

      # TODO: email from configuration
      adminAddr = "darkone@darkone.yt";
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
