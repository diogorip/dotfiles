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
          rev = "2e8d747b4e6ee4a63475024a599dabc4cc75d139";
          hash = "sha256-+wW1qoXfCi5d9isUiatbpKx6Esg1RzhmtTqV7bFzgBA=";
        };
        "homebrew/homebrew-cask" = pkgs.fetchFromGitHub {
          owner = "homebrew";
          repo = "homebrew-cask";
          rev = "ac3bea955fb6aa91c40fa186278989b4ae673ac6";
          hash = "sha256-fdHjd9Djje69tmduH8pNqHnrQzjILZO+wn8C9iHZZZo=";
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
        "podman"
        "podman-compose"
        "mas"
      ];

      casks = [
        "1password"
        "1password-cli"
        "aldente"
        "font-maple-mono"
        "signal"
        "raycast"
        "zen"
        "sketch@beta"
      ]
      ++ lib.optionals config.sys.profiles.gaming.enable [
        "steam"
        "prismlauncher"
      ];
    };
  };
}
