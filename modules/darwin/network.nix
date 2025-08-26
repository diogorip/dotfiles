{
  networking = {
    applicationFirewall = {
      enable = true;
      blockAllIncoming = false;
      allowSignedApp = false;
      allowSigned = true;
      enableStealthMode = true;
    };
    knownNetworkServices = [
      "Wi-Fi"
    ];
    dns = [
      "1.1.1.1"
      "1.0.0.1"
      "2606:4700:4700::1111"
      "2606:4700:4700::1001"
    ];
  };
}
