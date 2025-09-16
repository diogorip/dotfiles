{
  imports = [
    ./hardware.nix
  ];

  sys = {
    profiles.headless.enable = true;
    services = {
      caddy.enable = true;
      docker.enable = true;
      asf.enable = true;
      postgresql.enable = true;
      website.enable = true;
      cloudflared.enable = true;
    };
    networking.wireguard.enable = true;
  };

  system.stateVersion = "25.05";
}
