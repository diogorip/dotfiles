{ inputs, ... }:
{
  _class = "darwin";

  system.defaults.CustomUserPreferences."com.apple.AdLib".allowApplePersonalizedAdvertising = false;

  imports = [
    ../shared
    inputs.home-manager.darwinModules.home-manager
    ./preferences.nix
    ./network.nix
    ./keyboard.nix
    ./brew.nix
    ./services
  ];

  system.stateVersion = 6;
}
