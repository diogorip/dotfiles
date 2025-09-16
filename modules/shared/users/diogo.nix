{
  lib,
  config,
  ...
}:
let
  inherit (lib) elem mkIf;
in
{
  config = mkIf (elem "diogo" config.sys.users) {
    users.users.diogo.openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIE4wh28BWFp9Jql1BEzEO5RjtlmzBqRSXjGo03a8qXdd"
    ];
  };
}
