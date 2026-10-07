# cmconf

Portable personal configs consumed via [chezmoi externals](https://www.chezmoi.io/user-guide/include-files-from-elsewhere/).

## Layout

```
zsh/
  path.sh        PATH management utilities (prepend_to_path, append_to_path)
  shell.sh       oh-my-zsh, starship, zoxide, chezmoi aliases
  editor.sh      EDITOR=nvim, aliases
  git.sh         git aliases (gs, gpp, ghprcd, gai)
config/
  nvim/          LazyVim + catppuccin theme
  alacritty/     terminal emulator config
  zellij/        terminal multiplexer (catppuccin-mocha)
  starship.toml  prompt theme
  tridactyl/     Firefox vim bindings, disabled on Google apps (needs :nativeinstall)
gitconfig        personal git identity
```

## Usage

### A) Fresh machine setup

The chezmoi source (`.chezmoiexternal.toml`, `dot_zshrc`, `dot_zshenv`) lives in
`chezmoi/` in this repo; `.chezmoiroot` points chezmoi at it. The rest of the repo is the
content that the externals pull in.

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- -b ~/.local/bin
chezmoi init gerrygoo/cmconf
chezmoi apply
```

Tools the configs expect: zsh, oh-my-zsh, starship, zoxide, fzf, neovim, zellij.

### B) Daily operations

Configs are pulled automatically by chezmoi based on `refreshPeriod` (default: 168h / 1 week).

Force a refresh:
```bash
chezmoi apply --refresh-externals
```

Check what would change:
```bash
chezmoi diff --include=externals
```

### C) Maintenance

Edit configs in this repo, commit, push. All consuming machines pick up changes on next `chezmoi apply --refresh-externals` (or automatically after the refresh period expires).

```bash
cd ~/code/cmconf

# Edit
vim config/nvim/lua/plugins/catppuccin.lua

# Commit and push
git add -A && git commit -m "tweak: adjust catppuccin style"
git push origin main

# Force-refresh on current machine
chezmoi apply --refresh-externals
```

To add a new config file:
1. Add it to this repo under the appropriate directory
2. Add a matching entry in `chezmoi/.chezmoiexternal.toml`, commit and push
3. Run `chezmoi apply --refresh-externals`

## History

- **tmux** (tmux.conf: vim bindings, tpm, catppuccin) was replaced by zellij. Last version is at tag `tmux-last` (`git show tmux-last:tmux.conf`).
