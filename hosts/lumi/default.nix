{ config, ... }:
{
  sys = {
    profiles.headless.enable = true;
    services = {
      caddy.enable = true;
      docker.enable = true;
      asf.enable = true;
      postgresql.enable = true;
      woodpecker-server.enable = true;
      woodpecker-agent.enable = true;
      website.enable = true;
    };
  };

  fileSystems."/" = {
    device = "/dev/sda1";
    fsType = "ext4";
  };

  boot = {
    loader.grub = {
      enable = true;
      device = "/dev/sda";
    };

    initrd = {
      availableKernelModules = [
        "ata_piix"
        "uhci_hcd"
        "xen_blkfront"
        "vmw_pvscsi"
      ];
      kernelModules = [ "nvme" ];
    };

    kernelParams = [ "console=ttyS0,115200n8" ];

    tmp.cleanOnBoot = true;
  };

  zramSwap.enable = true;

  system.stateVersion = "25.05";
}
