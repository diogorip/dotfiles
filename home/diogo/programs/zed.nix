{ config, ... }:
{
  programs.zed-editor = {
    inherit (config.sys.profiles.graphical) enable;

    userSettings = {
      telemetry = {
        diagnostics = false;
        metrics = false;
      };

      vim_mode = true;

      ui_font_size = 16;
      buffer_font_family = "Maple Mono";
      buffer_font_size = 18;

      project_panel = {
        dock = "right";
      };
    };
    extensions = [
      "git-firefly"
      "vue"
      "dockerfile"
      "docker-compose"
      "nix"
      "discord-presence"
    ];
  };
}
