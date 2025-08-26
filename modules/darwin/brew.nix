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
          rev = "481ae0c7e1591b8d6bc8e30a715daadbb41e281b";
          hash = "sha256-Z63K/AeNJP709Vh0Wwq1TtJUwuK5zFUMqbFEzE4qfjE=";
        };
        "homebrew/homebrew-cask" = pkgs.fetchFromGitHub {
          owner = "homebrew";
          repo = "homebrew-cask";
          rev = "886976b4942c7695a0a16a1b1241b776f20bf13c";
          hash = "sha256-AQ2k926S5OaT9RkLVZ2aoRfyoZM2/66aV5KP5rCzgyQ=";
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
