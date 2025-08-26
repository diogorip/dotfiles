{
  self,
  lib,
  config,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (self.lib) mkServiceOption;

  cfg = config.sys.services.caddy;
in
{
  options = {
    sys.services.caddy = mkServiceOption "caddy" {
      domain = "luvsick.gg";
    };
  };

  config = mkIf cfg.enable {
    sops.secrets.bunny = {
      sopsFile = "${self}/secrets/services/bunny.yaml";
      owner = "caddy";
      group = "caddy";
    };

    networking = { inherit (cfg) domain; };

    security.acme = {
      acceptTerms = true;
      defaults.email = "contact@luvsick.gg";
      certs.${cfg.domain} = {
        extraDomainNames = [ "*.${cfg.domain}" ];
        dnsProvider = "bunny";
        credentialsFile = config.sops.secrets.bunny.path;
      };
    };

    users.users.caddy.extraGroups = [ "acme" ];

    services.caddy.enable = true;
  };
}
