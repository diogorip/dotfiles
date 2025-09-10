{
  imports = [
    ./hardware.nix
    ./networking.nix
  ];

  sys = {
    profiles.headless.enable = true;
    services = {
      caddy.enable = true;
      docker.enable = true;
      asf.enable = true;
      postgresql.enable = true;
      forgejo.enable = true;
      website.enable = true;
      cloudflared.enable = true;
      anubis.enable = true;
    };
  };

  system.stateVersion = "25.05";
}
