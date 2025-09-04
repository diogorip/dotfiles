{
  self,
  lib,
  config,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (self.lib) mkServiceOption;

  cfg = config.sys.services.asf;
in
{
  options.sys.services.asf = mkServiceOption "asf" {
    port = 1242;
  };

  config = mkIf config.sys.services.asf.enable {
    sops.secrets.asf = {
      sopsFile = "${self}/secrets/services/asf.yaml";
      owner = "archisteamfarm";
      group = "archisteamfarm";
    };

    services.archisteamfarm = {
      enable = true;
      web-ui.enable = true;
      settings = {
        SteamOwnerID = 76561198950840617;
        OptimizationMode = 1;
      };
      ipcSettings = {
        Kestrel = {
          Endpoints = {
            HTTP = {
              Url = "http://*:${toString cfg.port}";
            };
          };
        };
      };
      ipcPasswordFile = config.sops.secrets.asf.path;
    };
  };
}
