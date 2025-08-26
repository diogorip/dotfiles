{ pkgs, ... }:
{
  imports = [
    ./git.nix
    ./hyfetch
    ./zsh.nix
    ./ohmyposh
    ./btop.nix
    ./ssh.nix
    ./fzf.nix
    ./gpg.nix
    ./neovim
    ./tmux.nix
    ./kitty
    ./firefox.nix
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
      ;
  };
}
