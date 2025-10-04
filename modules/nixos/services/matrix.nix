{
  self,
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (self.lib) mkServiceOption;

  cfg = config.sys.services.matrix;

  domain = config.networking.domain;
in
{
  options = {
    sys.services.matrix = mkServiceOption "matrix" {
      domain = "matrix.${config.sys.services.caddy.domain}";
      port = 8008;
    };
  };

  config = mkIf cfg.enable {
    sops.secrets.matrix = {
      sopsFile = "${self}/secrets/services/matrix.yaml";
      owner = "matrix-synapse";
    };

    services = {
      matrix-synapse = {
        enable = true;
        extraConfigFiles = [ config.sops.secrets.matrix.path ];
        settings = {
          server_name = domain;
          public_baseurl = "https://${domain}";
          serve_server_wellknown = true;
          admin_contact = "mailto:hi+matrix@${domain}";
          enable_registration = true;
          registration_requires_token = true;
          bcrypt_rounds = 14;

          database = {
            name = "psycopg2";
            args = {
              host = "/run/postgresql";
              user = "matrix-synapse";
              database = "matrix-synapse";
            };
          };

          listeners = [
            {
              inherit (cfg) port;
              bind_addresses = [ "::1" ];
              resources = [
                {
                  names = [
                    "client"
                    "federation"
                  ];
                  compress = true;
                }
              ];
              tls = false;
              type = "http";
              x_forwarded = true;
            }
          ];
        };
      };

      postgresql = {
        initialScript = pkgs.writeText "synapse-init.sql" ''
          CREATE ROLE "matrix-synapse" WITH LOGIN PASSWORD 'synapse';
          CREATE DATABASE "matrix-synapse" WITH OWNER "matrix-synapse"
            TEMPLATE template0
            LC_COLLATE = "C"
            LC_CTYPE = "C";
        '';
      };

      caddy.virtualHosts.${domain} = {
        serverAliases = [ "${cfg.domain}" ];
        extraConfig = ''
          route /_matrix* {
            reverse_proxy http://[::1]:${toString cfg.port}
          }

          route /_synapse/client* {
            reverse_proxy http://[::1]:${toString cfg.port}
          }
        '';
      };
    };
  };
}
