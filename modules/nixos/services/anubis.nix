{
  self,
  lib,
  config,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (self.lib) mkServiceOption;

  cfg = config.sys.services.anubis;
in
{
  options = {
    sys.services.anubis = mkServiceOption "anubis" { };
  };

  config = mkIf cfg.enable {
    users.users.caddy.extraGroups = [ config.users.groups.anubis.name ];
  };
}
