{ lib, config, ... }:
{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    matchBlocks = {
      "*" = {
        hashKnownHosts = true;
        compression = true;
      };

      "github.com" = {
        user = "git";
        hostname = "github.com";
      };
    };

    extraConfig = lib.mkIf config.sys.profiles.graphical.enable ''
      Host *
        IdentityAgent "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
    '';
  };
}
