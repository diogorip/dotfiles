{
  services.fail2ban = {
    enable = true;
    banaction = "iptables-multiport[blocktype=DROP]";
    maxretry = 3;
    ignoreIP = [
      "127.0.0.0/8"
      "10.0.0.0/8"
      "192.168.0.0/16"
    ];

    bantime-increment = {
      enable = true;
      rndtime = "12m";
      multipliers = "4 8 16 32 64 128 256 512 1024 2048";
      maxtime = "192h";
    };
  };
}
