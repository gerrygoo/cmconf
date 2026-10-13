#!/usr/bin/env bash
# Ubuntu bootstrap: install the tools cmconf expects, then apply it with chezmoi.
# Safe to re-run. Usage: curl -fsSL https://raw.githubusercontent.com/gerrygoo/cmconf/main/bootstrap-ubuntu.sh | bash
set -euo pipefail

BIN="$HOME/.local/bin"
mkdir -p "$BIN"
export PATH="$BIN:$PATH"

case "$(uname -m)" in
  x86_64) ARCH=x86_64; NVIM_ARCH=x86_64 ;;
  aarch64|arm64) ARCH=aarch64; NVIM_ARCH=arm64 ;;
  *) echo "unsupported architecture: $(uname -m)" >&2; exit 1 ;;
esac

sudo apt-get update
sudo apt-get install -y zsh git curl tar fzf ripgrep build-essential

if ! command -v zoxide >/dev/null; then
  sudo apt-get install -y zoxide \
    || curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
fi

if ! command -v starship >/dev/null; then
  curl -sS https://starship.rs/install.sh | sh -s -- -y -b "$BIN"
fi

# apt's neovim is too old for LazyVim, so use the official release tarball.
if ! command -v nvim >/dev/null; then
  curl -fsSL "https://github.com/neovim/neovim/releases/latest/download/nvim-linux-${NVIM_ARCH}.tar.gz" \
    | tar -xz -C "$HOME/.local"
  ln -sf "$HOME/.local/nvim-linux-${NVIM_ARCH}/bin/nvim" "$BIN/nvim"
fi

if ! command -v zellij >/dev/null; then
  curl -fsSL "https://github.com/zellij-org/zellij/releases/latest/download/zellij-${ARCH}-unknown-linux-musl.tar.gz" \
    | tar -xz -C "$BIN" zellij
fi

if [ ! -d "$HOME/.oh-my-zsh" ]; then
  RUNZSH=no CHSH=no KEEP_ZSHRC=yes \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

if ! command -v chezmoi >/dev/null; then
  sh -c "$(curl -fsLS get.chezmoi.io)" -- -b "$BIN"
fi
chezmoi init --apply gerrygoo/cmconf

ZSH_PATH="$(command -v zsh)"
if [ "$SHELL" != "$ZSH_PATH" ]; then
  sudo chsh -s "$ZSH_PATH" "$USER"
fi

echo "Done. Log out and back in, then open nvim once so LazyVim installs its plugins."
