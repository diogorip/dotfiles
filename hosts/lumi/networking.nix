{
  networking = {
    interfaces.ens3 = {
      ipv6 = {
        routes = [
          {
            address = "2001:41d0:305:2100::1";
            prefixLength = 128;
          }
        ];

        addresses = [
          {
            address = "2001:41d0:305:2100::7785";
            prefixLength = 128;
          }
        ];
      };

      ipv4.addresses = [
        {
          address = "51.75.255.245";
          prefixLength = 32;
        }
      ];
    };
    defaultGateway = "51.75.248.1";
    defaultGateway6 = "2001:41d0:305:2100::1";
  };
}
