{
  lib,
  config,
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

      "lumi".hostname = "2001:41d0:305:2100::7785";

      "codeberg.org" = {
        user = "git";
        hostname = "codeberg.org";
      };

      "github.com" = {
        user = "git";
        hostname = "github.com";
      };
    };
  };
}
