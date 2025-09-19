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
      "1.1.1.2"
      "1.0.0.2"
      "2606:4700:4700::1112"
      "2606:4700:4700::1002"
    ];
  };
}
