{ pkgs, config, ... }:
{
  programs.ghostty = {
    enable = true;
    package = pkgs.ghostty-bin;
    enableZshIntegration = config.programs.zsh.enable;
    installBatSyntax = config.programs.bat.enable;
    settings = {
      font-family = "Maple Mono";
      font-size = 18;
      font-thicken = true;
      background-opacity = 0.95;
      background-blur = true;
      window-padding-x = 12;
      window-padding-y = 12;
      macos-titlebar-style = "tabs";
      window-save-state = "always";
      bell-features = "no-audio";
      macos-option-as-alt = true;
    };
  };
}
