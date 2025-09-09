{
  lib,
  config,
  pkgs,
  ...
}:
{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    matchBlocks = {
      "*" = {
        hashKnownHosts = true;
        compression = true;
        identityAgent = lib.mkIf config.sys.profiles.graphical.enable ''"~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"'';
      };

      "git.luvsick.gg" = {
        user = "git";
        hostname = "ssh.luvsick.gg";
        proxyCommand = "${pkgs.cloudflared}/bin/cloudflared access ssh --hostname %h";
      };
    };
  };
}
