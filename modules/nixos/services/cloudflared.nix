{
  self,
  lib,
  config,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (self.lib) mkServiceOption;

  cfg = config.sys.services.cloudflared;
in
{
  options = {
    sys.services.cloudflared = mkServiceOption "cloudflared" {
      domain = "luvsick.gg";
    };
  };

  config = mkIf cfg.enable {
    sops.secrets.cloudflared-lumi = {
      sopsFile = "${self}/secrets/services/cloudflare.yaml";
      key = "lumi";
    };

    networking = { inherit (cfg) domain; };

    services.cloudflared = {
      enable = true;
      tunnels.${config.networking.hostName} = {
        credentialsFile = config.sops.secrets.cloudflared-lumi.path;
        default = "http_status:404";
      };
    };
  };
}
