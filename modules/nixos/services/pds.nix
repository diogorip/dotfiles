{
  self,
  lib,
  config,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (self.lib) mkServiceOption;

  cfg = config.sys.services.pds;
in
{
  options.sys.services.pds = mkServiceOption "pds" {
    domain = "at.${config.sys.services.caddy.domain}";
    port = 3601;
  };

  config = mkIf cfg.enable {
    sops.secrets.pds.sopsFile = "${self}/secrets/services/pds.yaml";

    services = {
      pds = {
        enable = true;
        pdsadmin.enable = true;

        environmentFiles = [
          config.sops.secrets.pds.path
        ];

        settings = {
          PDS_PORT = cfg.port;
          PDS_HOSTNAME = cfg.domain;
        };
      };

      caddy.virtualHosts.${cfg.domain} = {
        extraConfig = ''
          reverse_proxy localhost:${toString cfg.port}
        '';
      };
    };
  };
}
