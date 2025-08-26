{ lib, ... }:
{
  security = {
    sudo = {
      enable = true;
      wheelNeedsPassword = lib.mkDefault false;
      execWheelOnly = true;
    };
  };
}
