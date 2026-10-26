#!/usr/bin/env bash
# git-pull-all.sh — fast-forward pull every git repo under ~/code (or $1)

root="${1:-$HOME/code}"
failed=()

while IFS= read -r gitdir; do
    repo="${gitdir%/.git}"
    name="${repo#"$root"/}"
    if ! git -C "$repo" rev-parse --abbrev-ref --symbolic-full-name '@{u}' >/dev/null 2>&1; then
        printf '\033[33m-- %s: no upstream, skipped\033[0m\n' "$name"
        continue
    fi
    printf '\033[36m== %s\033[0m\n' "$name"
    git -C "$repo" pull --ff-only --prune || failed+=("$name")
done < <(find "$root" -maxdepth 4 -name node_modules -prune -o -name .git -print | sort)

if ((${#failed[@]})); then
    printf '\033[31mFailed: %s\033[0m\n' "${failed[*]}"
    exit 1
fi
