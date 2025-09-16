{
  pkgs,
  inputs,
  config,
  lib,
  ...
}:
{
  imports = [
    inputs.homebrew.darwinModules.nix-homebrew
    ./environment.nix
  ];

  config = {
    nix-homebrew = {
      enable = true;
      taps = {
        "homebrew/homebrew-core" = pkgs.fetchFromGitHub {
          owner = "homebrew";
          repo = "homebrew-core";
          rev = "10bd122b5d16ee57ad03fcbadeeca9d51d158788";
          hash = "sha256-V4LCTzpHTY8dBUV/ww4dOtOhxoOb7VsbIFN+YMA+gO0=";
        };
        "homebrew/homebrew-cask" = pkgs.fetchFromGitHub {
          owner = "homebrew";
          repo = "homebrew-cask";
          rev = "0d81408724412838d4d3299396535cafb095ac9e";
          hash = "sha256-auiDJuAW4QYhYrfKJvBBJaF8yBxkZIIRmvp6cgvFV/o=";
        };
        "koekeishiya/homebrew-formulae" = pkgs.fetchFromGitHub {
          owner = "koekeishiya";
          repo = "homebrew-formulae";
          rev = "f5711b9c70e104bffc79e3525e2ed0dc335bdbba";
          hash = "sha256-e7NybFVmFDHHy8m+cJPnDugGKzfYkMvh/3c+O7jMM2Y=";
        };
      };
      mutableTaps = false;
      user = "diogo";
      autoMigrate = true;
    };

    homebrew = {
      enable = true;

      global.autoUpdate = true;

      onActivation = {
        upgrade = true;
        cleanup = "zap";
      };

      taps = builtins.attrNames config.nix-homebrew.taps;

      masApps = {
        "Pages" = 409201541;
        "TestFlight" = 899247664;
        "WhatsApp" = 310633997;
        "WireGuard" = 1451685025;
      };

      brews = [
        "docker"
        "docker-compose"
        "mas"
        "koekeishiya/formulae/yabai"
        "koekeishiya/formulae/skhd"
      ];

      casks = [
        "1password"
        "1password-cli"
        "aldente"
        "font-maple-mono"
        "kitty"
        "signal"
        "vesktop"
        "raycast"
        "zen@twilight"
        "zed"
        "sketch@beta"
      ]
      ++ lib.optionals config.sys.profiles.gaming.enable [ "steam" ];
    };
  };
}
