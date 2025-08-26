{ inputs, ... }:
{
  _class = "nixos";

  imports = [
    ../shared
    inputs.home-manager.nixosModules.home-manager
    ./headless.nix
    ./networking
    ./sudo.nix
    ./secrets.nix
    ./services
    ./users
  ];

  nix = {
    gc.dates = "Mon *-*-* 04:00";

    optimise = {
      automatic = true;
      dates = [ "04:30" ];
    };

    settings = {
      build-dir = "/var/tmp";
    };
  };
}
