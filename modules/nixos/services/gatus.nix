{
  lib,
  self,
  config,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (self.lib) mkServiceOption;

  cfg = config.sys.services.gatus;
in
{
  options.sys.services.gatus = mkServiceOption "gatus" {
    domain = "status.${config.sys.services.caddy.domain}";
    port = 3060;
  };

  config = mkIf cfg.enable {
    services = {
      gatus = {
        enable = true;

        settings = {
          web.port = cfg.port;
          ui = {
            title = "Status - luvsick.gg";
            header = "luvsick.gg Status";
            logo = "https://cdn.luvsick.gg/notobunny.png";
          };
          endpoints = [{
            name = "website";
            url = "https://luvsick.gg";
            interval = "5m";
            conditions = [
              "[STATUS] == 200"
              "[RESPONSE_TIME] < 300"
            ];
          }];
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
