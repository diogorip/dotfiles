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
    users.users.diogo.hashedPassword = "$6$h/hPw1aKAbw/WKxy$IEnxYGD/esK890EjR5i4TlrDj6ph4DfZpiUdQ2FZp/LqXAkNzSN2BXUlmL4QQWJHsvjlbzIvULeLigfATRzyC.";
  };
}
