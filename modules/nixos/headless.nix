{ lib, config, ... }:
{
  config = lib.mkIf config.sys.profiles.headless.enable {
    environment.variables.BROWSER = "echo";

    systemd = {
      enableEmergencyMode = false;
    };
  };
}
