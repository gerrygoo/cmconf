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
  starship.toml  prompt theme
tmux.conf        tmux with vim bindings, tpm, catppuccin
gitconfig        personal git identity
```

## Usage

### A) Fresh machine setup

1. Install chezmoi:
   ```bash
   sh -c "$(curl -fsLS get.chezmoi.io)"
   ```

2. Init a minimal chezmoi source:
   ```bash
   chezmoi init
   ```

3. Create `~/.local/share/chezmoi/.chezmoiexternal.toml`:
   ```toml
   [".zsh/path.sh"]
       type = "file"
       url = "https://raw.githubusercontent.com/gerrygoo/cmconf/main/zsh/path.sh"

   [".zsh/shell.sh"]
       type = "file"
       url = "https://raw.githubusercontent.com/gerrygoo/cmconf/main/zsh/shell.sh"

   [".zsh/editor.sh"]
       type = "file"
       url = "https://raw.githubusercontent.com/gerrygoo/cmconf/main/zsh/editor.sh"

   [".zsh/git.sh"]
       type = "file"
       url = "https://raw.githubusercontent.com/gerrygoo/cmconf/main/zsh/git.sh"

   [".config/nvim"]
       type = "archive"
       url = "https://github.com/gerrygoo/cmconf/archive/main.tar.gz"
       stripComponents = 3
       include = ["*/config/nvim/**"]

   [".config/alacritty"]
       type = "archive"
       url = "https://github.com/gerrygoo/cmconf/archive/main.tar.gz"
       stripComponents = 3
       include = ["*/config/alacritty/**"]

   [".config/starship.toml"]
       type = "file"
       url = "https://raw.githubusercontent.com/gerrygoo/cmconf/main/config/starship.toml"

   [".tmux.conf"]
       type = "file"
       url = "https://raw.githubusercontent.com/gerrygoo/cmconf/main/tmux.conf"

   [".gitconfig"]
       type = "file"
       url = "https://raw.githubusercontent.com/gerrygoo/cmconf/main/gitconfig"
   ```

4. Create a minimal `~/.local/share/chezmoi/dot_zshrc`:
   ```bash
   source ~/.zsh/path.sh
   source ~/.zsh/shell.sh
   source ~/.zsh/editor.sh
   source ~/.zsh/git.sh
   ```

5. Apply:
   ```bash
   chezmoi apply
   ```

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
2. Add a matching entry in `.chezmoiexternal.toml` on each consuming machine
3. Run `chezmoi apply --refresh-externals`
