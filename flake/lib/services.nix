# original: https://github.com/isabelroses/dotfiles/blob/main/modules/flake/lib/services.nix
{ lib, ... }:
let
  inherit (lib.types) str;
  inherit (lib.options) mkOption mkEnableOption;

  mkServiceOption =
    name:
    {
      port ? 0,
      host ? "127.0.0.1",
      domain ? "",
      extraConfig ? { },
    }:
    {
      enable = mkEnableOption "Enable the ${name} service";

      host = mkOption {
        type = str;
        default = host;
        description = "Host where the ${name} service will run on";
      };

      port = mkOption {
        type = lib.types.port;
        default = port;
        description = "Port where the ${name} service will run on";
      };

      domain = mkOption {
        type = str;
        default = domain;
        defaultText = "networking.domain";
        description = "Domain for the ${name} service";
      };
    }
    // extraConfig;
in
{
  inherit mkServiceOption;
}
