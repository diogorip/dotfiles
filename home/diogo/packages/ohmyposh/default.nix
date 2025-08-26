{
  programs.ohmyposh = {
    enable = true;
    enableZshIntegration = true;
    settings = builtins.fromJSON (builtins.readFile ./config.json);
  };
}
