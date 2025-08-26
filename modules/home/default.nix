{
  _class = "homeManager";

  imports = [
    ../shared/packages.nix
    ../shared/profiles.nix
    ./home.nix
    ./profiles.nix
    ./secrets.nix
  ];
}
