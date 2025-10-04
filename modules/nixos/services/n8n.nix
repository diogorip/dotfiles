{
  self,
  lib,
  config,
  ...
}:
let
  inherit (lib) mkIf mkForce;
  inherit (self.lib) mkServiceOption;

  cfg = config.sys.services.n8n;
in
{
  options = {
    sys.services.n8n = mkServiceOption "n8n" {
      domain = "n8n.${config.sys.services.caddy.domain}";
      port = 5678;
    };
  };

  config = mkIf cfg.enable {
    services = {
      n8n = {
        enable = true;
        settings = {
          DB_TYPE = mkForce "postgresdb";
          DB_POSTGRESDB_USER = "n8n";

          N8N_PUSH_BACKEND = "sse";
          N8N_HIRING_BANNER_ENABLED = false;
          N8N_PORT = cfg.port;
          N8N_HOST = cfg.domain;
          N8N_METRICS = true;
          N8N_HIDE_USAGE_PAGE = true;
          GENERIC_TIMEZONE = "Europe/Lisbon";
          N8N_PROTOCOL = "https";
        };
      };

      postgresql = {
        ensureDatabases = [ "n8n" ];
        ensureUsers = lib.singleton {
          name = "n8n";
          ensureDBOwnership = true;
        };
      };

      caddy.virtualHosts.${cfg.domain}.extraConfig = ''reverse_proxy localhost:${toString cfg.port}'';
    };
  };
}
