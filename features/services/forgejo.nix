# NE FONCTIONNE PAS

{ pkgs, config, ... }:
let
  cfg = config.services.forgejo;
  srv = cfg.settings.server;
in {
  services.nginx = {
    enable = true;
    recommendedGzipSettings = true;
    virtualHosts.${srv.DOMAIN} = {
      #enableACME = true;
      #forceSSL = true;
      extraConfig = ''
        client_max_body_size 512M;
      '';
      locations."/".proxyPass = "http://localhost:${toString srv.HTTP_PORT}";
    };
  };

  services.forgejo = {
    enable = true;
    #database.type = "sqlite3"; # Default sqlite3
    useWizard = true;
    user = "gponcon";
    stateDir = "/home/gponcon/Forgejo";
    lfs.enable = true;
    settings = {
      DEFAULT = { APP_NAME = "Une forge pédagogique"; };
      server = {
        DOMAIN = "localhost";
        ROOT_URL = "http://${srv.DOMAIN}/";
        HTTP_PORT = 3000;
        LANDING_PAGE = "explore";
        APP_DATA_PATH = "settings.server.APP_DATA_PATH";
      };
      "service.explore" = { DISABLE_USERS_PAGE = true; };
      "ui.meta" = {
        AUTHOR = "G. Ponçon";
        DESCRIPTION = "Une forge pédagogique";
      };
    };
  };

  users.users.gponcon.extraGroups = [ "forgejo" ];

  # Paquetages spécifiques forgejo
  environment.systemPackages = with pkgs; [ sqlite forgejo-cli ];
}
