{ osConfig, ... }:
let
  cfg = osConfig.sys.profiles;
in
{
  sys.profiles = {
    inherit (cfg)
      graphical
      headless
      gaming
      ;
  };
}
