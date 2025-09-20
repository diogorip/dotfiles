{
  lib,
  self,
  config,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (self.lib) mkServiceOption;
in
{
  options.sys.services.docker = mkServiceOption "docker" { };
  config = mkIf config.sys.services.docker.enable {
    virtualisation.docker.enable = true;
  };
}
