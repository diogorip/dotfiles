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
      domain = "diogo.rip";
    };
  };

  config = mkIf cfg.enable {
    sops.secrets.cloudflare-cert = {
      sopsFile = "${self}/secrets/services/cloudflare.yaml";
      key = "cert";
      owner = "caddy";
      group = "caddy";
    };

    networking = { inherit (cfg) domain; };

    security.acme = {
      acceptTerms = true;
      defaults.email = "hi@diogo.rip";
      certs.${cfg.domain} = {
        extraDomainNames = [ "*.${cfg.domain}" ];
        dnsProvider = "cloudflare";
        credentialsFile = config.sops.secrets.cloudflare-cert.path;
      };
    };

    users.users.caddy.extraGroups = [ "acme" ];

    services.caddy.enable = true;
  };
}
