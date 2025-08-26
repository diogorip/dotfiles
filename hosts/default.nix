{ self, inputs, ... }:
{
  imports = [ inputs.easy-hosts.flakeModule ];

  config.easy-hosts = {
    perClass = class: {
      modules = [ "${self}/modules/${class}" ];
    };

    hosts = {
      bunni = {
        arch = "aarch64";
        class = "darwin";
      };
    };
  };
}
