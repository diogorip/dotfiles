{
  lib,
  self,
  config,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (self.lib) mkServiceOption;

  cfg = config.sys.services.forgejo;
in
{
  options.sys.services.forgejo = mkServiceOption "forgejo" {
    domain = "git.${config.sys.services.caddy.domain}";
    port = 5060;
  };

  config = mkIf cfg.enable {
    networking.firewall.allowedTCPPorts = [
      config.services.forgejo.settings.server.HTTP_PORT
      config.services.forgejo.settings.server.SSH_PORT
    ];

    users = {
      groups.git = { };

      users.git = {
        isSystemUser = true;
        createHome = false;
        group = "git";
      };
    };

    services = {
      forgejo = {
        enable = true;
        package = pkgs.forgejo;
        lfs.enable = true;
        settings = {
          server = {
            START_SSH_SERVER = true;
            SSH_PORT = 2222;
            SSH_LISTEN_PORT = 2222;
            SSH_CREATE_AUTHORIZED_KEYS_FILE = true;
            PROTOCOL = "http+unix";
            ROOT_URL = "https://${cfg.domain}";
            DOMAIN = cfg.domain;
            HTTP_PORT = cfg.port;
            BUILTIN_SSH_SERVER_USER = "git";
            DISABLE_ROUTER_LOG = true;
            OFFLINE_MODE = false;
          };
          api.ENABLE_SWAGGER = false;
          federation.ENABLED = true;
          DEFAULT.APP_NAME = "luvgit";
          database = {
            DB_TYPE = lib.mkForce "postgres";
            HOST = "0.0.0.0";
            NAME = "forgejo";
            USER = "forgejo";
            PASSWD = "forgejo";
          };
          service.DISABLE_REGISTRATION = true;
          other.SHOW_FOOTER_TEMPLATE_LOAD_TIME = false;
          picture.ENABLE_FEDERATED_AVATAR = true;
          ui.SHOW_USER_EMAIL = false;
          "ui.meta" = {
            AUTHOR = "luvsick.gg";
            DESCRIPTION = "luvsick's self-hosted forgejo";
            KEYWORDS = "git,forge,forgejo,gitea,self-hosted,open-source,luvsick";
          };
        };
      };

      postgresql = {
        ensureDatabases = [ "forgejo" ];
        ensureUsers = lib.singleton {
          name = "forgejo";
          ensureDBOwnership = true;
        };
      };

      caddy.virtualHosts.${cfg.domain}.extraConfig = ''
        reverse_proxy unix/${config.services.forgejo.settings.server.HTTP_ADDR}
      '';
    };
  };
}
