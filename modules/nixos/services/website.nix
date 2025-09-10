{
  lib,
  self,
  config,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (self.lib) mkServiceOption;

  cfg = config.sys.services.website;
in
{
  options.sys.services.website = mkServiceOption "website" {
    domain = "${config.sys.services.caddy.domain}";
    port = 5757;
  };

  config = mkIf cfg.enable {
    services.caddy.virtualHosts.${cfg.domain}.extraConfig = ''
      reverse_proxy localhost:${toString cfg.port}
    '';
  };
}
