{
  lib,
  self,
  config,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (self.lib) mkServiceOption;

  cfg = config.sys.services.uptime-kuma;
in
{
  options.sys.services.uptime-kuma = mkServiceOption "uptime-kuma" {
    domain = "status.${config.sys.services.caddy.domain}";
    port = 3060;
  };

  config = mkIf cfg.enable {
    services = {
      uptime-kuma = {
        enable = true;

        settings = {
          HOST = "127.0.0.1";
          PORT = toString cfg.port;
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
