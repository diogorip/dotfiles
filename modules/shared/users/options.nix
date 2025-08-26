{ lib, config, ... }:
let
  inherit (lib) mkOption optional;
  inherit (lib.types) listOf str;
in
{
  options.sys.users = mkOption {
    type = listOf str;
    default = [ "diogo" ];
    description = ''
      A list of users that the host will have.
    '';
  };

  config = {
    warnings = optional (config.sys.users == [ ]) ''
      You have not configured any users.

      Please set {option}`config.sys.users` in your host configuration.
    '';
  };
}
