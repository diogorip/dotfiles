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

    #   key = "website";
    #   owner = "anubis";
    #   group = "anubis";
    # };

    services = {
      anubis = mkIf config.sys.services.anubis.enable {
        instances.website.settings = {
          TARGET = "http://127.0.0.1:${toString cfg.port}";
          ED25519_PRIVATE_KEY_HEX_FILE = config.sops.secrets.anubis-website.path;
        };
      };

      caddy.virtualHosts.${cfg.domain}.extraConfig =
        ''reverse_proxy ''
        + (
          if config.sys.services.anubis.enable then
            "unix/" + config.services.anubis.instances.website.settings.BIND
          else
            "localhost:${toString cfg.port}"
        );
    };
  };
}
