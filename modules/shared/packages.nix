{
  lib,
  config,
  _class,
  ...
}:
{
  options.sys.packages = lib.mkOption {
    type = lib.types.attrsOf lib.types.package;
    default = { };
    description = ''
      List of packages to install.
    '';
  };

  config = lib.mergeAttrsList [
    (lib.optionalAttrs (_class == "nixos" || _class == "darwin") {
      environment.systemPackages = builtins.attrValues config.sys.packages;
    })

    (lib.optionalAttrs (_class == "homeManager") {
      home.packages = builtins.attrValues config.sys.packages;
    })
  ];
}
