#!/usr/bin/env bash
set -euo pipefail

if [[ "$(uname -s)" != "Darwin" || "$(uname -m)" != "arm64" ]]; then
  echo "This setup targets Apple Silicon macOS only." >&2
  exit 1
fi

repo_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
username="${USER:?USER is not set}"
home_directory="${HOME:?HOME is not set}"

if ! command -v nix >/dev/null 2>&1; then
  curl -sSf -L https://install.lix.systems/lix | sh -s -- install
fi

if ! command -v nix >/dev/null 2>&1; then
  if [[ -e /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]]; then
    # shellcheck disable=SC1091
    . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
  fi
fi

if ! command -v nix >/dev/null 2>&1; then
  echo "Lix installed, but nix is not on PATH yet. Open a new shell and rerun this script." >&2
  exit 1
fi

tmp_dir="$(mktemp -d)"
trap 'rm -rf "$tmp_dir"' EXIT

cat > "$tmp_dir/flake.nix" <<EOF
{
  inputs.env.url = "path:${repo_dir}";

  outputs = { env, ... }: {
    darwinConfigurations.macbook = env.lib.mkAppleSiliconMacBook {
      username = "${username}";
      homeDirectory = "${home_directory}";
    };
  };
}
EOF

sudo --preserve-env=PATH nix run github:nix-darwin/nix-darwin/master#darwin-rebuild -- switch --flake "$tmp_dir#macbook"
