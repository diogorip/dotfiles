flake_var := env_var_or_default("FLAKE", "")
flake := if flake_var =~ '^\.*$' { justfile_directory() } else { flake_var }
rebuild := if os() == "macos" { "sudo darwin-rebuild" } else { "nixos-rebuild" }
system-args := if os() != "macos" { "--sudo --no-reexec" } else { "" }

[private]
default:
    @just --list --unsorted

[group('rebuild')]
[private]
builder goal *args:
    {{ rebuild }} {{ goal }} \
      --flake {{ flake }} \
      {{ system-args }} \
      {{ args }}

[group('rebuild')]
switch *args: (builder "switch" args)

[group('rebuild')]
[macos]
provision host:
    sudo nix run nix-darwin/master -- switch --flake {{ flake }}#{{ host }}

[group('rebuild')]
deploy host *args: (builder "switch" "--build-host " + host "--target-host " + host "--use-substitutes " + args)

[group('utils')]
clean:
    nix-collect-garbage --delete-older-than 3d
    nix store optimise

[group('utils')]
rotate:
  /usr/bin/find secrets/ -name "*.yaml" | xargs -I {} sops rotate -i {}
  /usr/bin/find secrets/ -name "*.yaml" | xargs -I {} sops updatekeys -y {}

[group('utils')]
update:
  nix flake update \
    --commit-lock-file \
    --commit-lockfile-summary "flake: update inputs" \
    --flake {{ flake }}
