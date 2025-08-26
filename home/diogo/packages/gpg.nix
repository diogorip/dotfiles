{ pkgs, ... }:
{
  sys.packages = { inherit (pkgs) pinentry-curses; };
  services.gpg-agent = {
    enable = true;
    pinentry.package = pkgs.pinentry-curses;
    enableSshSupport = false;
    defaultCacheTtl = 600;
    maxCacheTtl = 3600;
    enableZshIntegration = true;
  };

  programs.gpg.enable = true;
}
