# original: https://github.com/isabelroses/dotfiles/blob/main/modules/flake/lib/default.nix
{ lib, ... }:
let
  sysLib = lib.fixedPoints.makeExtensible (final: {
    services = import ./services.nix { inherit lib; };

    inherit (final.services) mkServiceOption;
  });
in
{
  flake.lib = sysLib;
}
