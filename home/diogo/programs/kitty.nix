{ config, ... }:
{
  programs.kitty = {
    inherit (config.sys.profiles.graphical) enable;
    font = {
      name = "Maple Mono";
      size = 18;
    };
    enableGitIntegration = config.programs.git.enable;
    shellIntegration.enableZshIntegration = config.programs.zsh.enable;
    settings = {
      enable_audio_bell = false;
      copy_on_select = true;

      window_border_width = 1.0;
      window_margin_width = 0.0;
      single_window_margin_width = 0.0;
      window_padding_width = "10 12";

      background_opacity = 0.95;
      background_blur = 20;

      macos_option_as_alt = "left";
      macos_quit_when_last_window_closed = true;
      hide_window_decorations = "titlebar-only";

      tab_bar_min_tabs = 1;
      tab_bar_edge = "top";
      tab_bar_style = "powerline";
      tab_powerline_style = "round";
      tab_title_template = "{title}{' :{}:'.format(num_windows) if num_windows > 1 else ''}";

      adjust_line_height = "105%";

      mouse_hide_wait = 3.0;
      kitty_mod = "cmd";
    };
    keybindings = {
      "kitty_mod+r" = "load_config_file";

      "kitty_mod+n" = "new_os_window_with_cwd";
      "kitty_mod+t" = "new_tab_with_cwd";

      "kitty_mod+shift+." = "move_tab_forward";
      "kitty_mod+shift+," = "move_tab_forward";

      "kitty_mod+1" = "goto_tab 1";
      "kitty_mod+2" = "goto_tab 2";
      "kitty_mod+3" = "goto_tab 3";
      "kitty_mod+4" = "goto_tab 4";
      "kitty_mod+5" = "goto_tab 5";
      "kitty_mod+6" = "goto_tab 6";
      "kitty_mod+7" = "goto_tab 7";
      "kitty_mod+8" = "goto_tab 8";
      "kitty_mod+9" = "goto_tab 9";
    };
  };
}
