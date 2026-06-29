# path.sh — PATH management utilities
# Must be sourced first — other modules depend on these functions.

append_to_path() {
  if [[ -d "$1" ]] && [[ ":$PATH:" != *":$1:"* ]]; then
    export PATH="$PATH:$1"
  fi
}

prepend_to_path() {
  if [[ -d "$1" ]] && [[ ":$PATH:" != *":$1:"* ]]; then
    export PATH="$1:$PATH"
  fi
}

prepend_to_path "$HOME/.local/bin"
prepend_to_path "$HOME/bin"
