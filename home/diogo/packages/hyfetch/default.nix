{
  programs.hyfetch = {
    enable = true;
    settings = {
      preset = "lesbian";
      mode = "rgb";
      light_dark = "dark";
      lightness = 0.7;

      color_align = {
        mode = "horizontal";
        custom_colors = [ ];
        fore_back = null;
      };

      backend = "fastfetch";
      args = null;
      distro = null;
      pride_month_shown = [ ];
      pride_month_disable = false;
    };
  };

  programs.fastfetch = {
    enable = true;
    settings = builtins.fromJSON (builtins.readFile ./fasfetch.jsonc);
  };
}
