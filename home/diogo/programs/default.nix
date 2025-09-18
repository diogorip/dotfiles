{ pkgs, ... }:
{
  imports = [
    ./git.nix
    ./hyfetch
    ./zsh.nix
    ./ohmyposh
    ./btop.nix
    ./neovim
    ./tmux.nix
    ./kitty.nix
    ./firefox.nix
    ./fzf.nix
    ./ripgrep.nix
    ./vesktop.nix
    ./zed.nix
  ];

  sys.packages = {
    inherit (pkgs)
      nodejs
      just
      glow
      bun
      charm-freeze
      age
      sops
      go
      rustc
      cargo
      deno
      ;
  };
}
