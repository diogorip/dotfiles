{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption;

  cfg = config.sys.networking.wireguard;
in
{
  options.sys.networking.wireguard.enable = mkEnableOption "WireGuard";

  config = mkIf cfg.enable {
    sys.packages = { inherit (pkgs) wireguard-tools; };

    networking = {
      firewall = {
        allowedUDPPorts = [ 51820 ];
        trustedInterfaces = [ "wg0" ];
      };

      nat = {
        enable = true;
        enableIPv6 = true;
        externalInterface = "ens3";
        internalInterfaces = [ "wg0" ];
      };

      wireguard.interfaces.wg0 = {
        ips = [
          "10.100.0.1/24"
          "fd00:1:1:1::1/64"
        ];
        listenPort = 51820;

        postSetup = ''
          ${pkgs.iptables}/bin/iptables -t nat -A POSTROUTING -s 10.100.0.0/24 -o ens3 -j MASQUERADE
        '';

        postShutdown = ''
          ${pkgs.iptables}/bin/iptables -t nat -D POSTROUTING -s 10.100.0.0/24 -o ens3 -j MASQUERADE
        '';

        privateKeyFile = "/root/wg-private";

        peers = [
          {
            publicKey = "I3IrbxHSdjIFWBZXvvDw2+5yvIBgfQyKJrGOhunVOSM=";
            allowedIPs = [
              "10.100.0.2/32"
              "fd00:1:1:1::2/128"
            ];
          }
        ];
      };
    };
  };
}
