{ config, ... }:
{
  imports = [
    ./fail2ban.nix
    ./firewall.nix
    ./openssh.nix
  ];

  networking = {
    hostId = builtins.substring 0 8 (builtins.hashString "md5" config.networking.hostName);

    networkmanager.enable = true;
  };
}
