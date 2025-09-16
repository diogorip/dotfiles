{ config, ... }:
{
  imports = [
    ./fail2ban.nix
    ./firewall.nix
    ./openssh.nix
    ./wireguard.nix
  ];

  networking = {
    hostId = builtins.substring 0 8 (builtins.hashString "md5" config.networking.hostName);

    networkmanager.enable = true;

    nameservers = [
      "1.1.1.1"
      "8.8.8.8"
      "2606:4700:4700::1111"
      "2001:4860:4860::8844"
    ];
  };
}
