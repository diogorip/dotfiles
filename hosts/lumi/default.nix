{
  imports = [
    ./hardware.nix
    ./networking.nix
  ];

  sys = {
    profiles.headless.enable = true;
    services = {
      caddy.enable = true;
      podman.enable = true;
      asf.enable = true;
      postgresql.enable = true;
      website.enable = true;
      cloudflared.enable = true;
      anubis.enable = true;
    };
    networking.wireguard.enable = true;
  };

  system.stateVersion = "25.05";
}
