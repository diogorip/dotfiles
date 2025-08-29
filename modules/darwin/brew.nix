{
  pkgs,
  inputs,
  config,
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
          rev = "dff4fc652f2fbe435ebbad69d0b8fb4207212175";
          hash = "sha256-drBTsJEEpclkPZ94iIpfMQwqmCVd5VCh7s7iI/qDkMY=";
        };
        "homebrew/homebrew-cask" = pkgs.fetchFromGitHub {
          owner = "homebrew";
          repo = "homebrew-cask";
          rev = "11c9f2b97fc160b0c717ff4acb5f7e4c8441c1b1";
          hash = "sha256-8sV8MJ8n8ZJB+g6hn96dl+zmwZ0mgwrcVTxU4FGEFSY=";
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
      };

      brews = [
        "colima"
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
        "steam"
        "vesktop"
        "raycast"
        "zen@twilight"
        "mullvad-vpn"
      ];
    };
  };
}
