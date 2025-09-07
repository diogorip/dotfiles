{
  lib,
  self,
  config,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (self.lib) mkServiceOption;

  scfg = config.sys.services.woodpecker-server;
  acfg = config.sys.services.woodpecker-agent;
in
{
  options.sys.services.woodpecker-server = mkServiceOption "woodpecker-server" {
    domain = "ci.${config.sys.services.caddy.domain}";
    port = 8000;
  };
  options.sys.services.woodpecker-agent = mkServiceOption "woodpecker-agent" { };

  config = mkIf (scfg.enable || acfg.enable) {
    sops.secrets.woodpecker = {
      sopsFile = "${self}/secrets/services/woodpecker.yaml";
    };

    services = {
      woodpecker-server = {
        enable = scfg.enable;
        environment = {
          WOODPECKER_HOST = "https://${scfg.domain}";
          WOODPECKER_SERVER_ADDR = ":${scfg.port}";
          WOODPECKER_GRPC_ADDR = ":9000";
          WOODPECKER_OPEN = "false";
          WOODPECKER_ADMIN = "luvsick";
        };
        environmentFile = [ config.sops.secrets.woodpecker.path ];
      };

      woodpecker-agents.agents.local = {
        enable = acfg.enable;
        environment = {
          WOODPECKER_HOSTNAME = "${config.networking.hostName}";
          WOODPECKER_BACKEND = "local";
        };
        environmentFile = [ config.sops.secrets.woodpecker.path ];
        path = [
          pkgs.git
          pkgs.git-lfs
          pkgs.bash
          pkgs.coreutils
          pkgs.nix
        ];
        extraGroups = [ "wheel" ];
      };

      caddy.virtualHosts = mkIf scfg.enable {
        ${scfg.domain} = {
          extraConfig = ''
            reverse_proxy localhost:${toString scfg.port}
          '';
        };
        "grpc.${scfg.domain}" = {
          extraConfig = ''
            reverse_proxy h2c://localhost:9000
          '';
        };
      };
    };
  };
}
