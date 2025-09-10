{
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
}
