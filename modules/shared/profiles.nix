{ lib, ... }:
let
  inherit (lib) mkEnableOption;
in
{
  options.sys.profiles = {
    graphical.enable = mkEnableOption "Graphical Interface";
    headless.enable = mkEnableOption "Headless";
  };
}
