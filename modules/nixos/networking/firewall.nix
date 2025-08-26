{ pkgs, config, ... }:
{
  config = {
    networking.firewall = {
      enable = true;
      package = pkgs.iptables;

      allowedTCPPorts = [
        80
        443
      ];
      allowedUDPPorts = [ ];

      allowedTCPPortRanges = [ ];
      allowedUDPPortRanges = [ ];

      allowPing = config.sys.profiles.headless.enable;
    };
  };
}
