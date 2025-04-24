#!/bin/bash

set -euo pipefail
IFS=$'\n'

LOCAL_DIR="$HOME/.local"
BIN_DIR="$LOCAL_DIR/bin"
mkdir -p "$BIN_DIR"

link_bin() {
  local target_bin="$1"
  local name="${2:-$(basename "$target_bin")}"
  ln -sf "$target_bin" "$BIN_DIR/$name"
}

echo "[*] installing language servers..."

# create array of unique install commands
declare -a unique_cmds=()
while read -r cmd; do
  [[ -n "$cmd" ]] && unique_cmds+=("$cmd")
done < <(grep -h -i "^-- *install with:" "$HOME/.config/nvim/lsp/"*.lua | sed -E 's/^-- *[Ii]nstall with: *//' | sort -u)

# execute unique commands in parallel
for cmd in "${unique_cmds[@]}"; do
  (
    # Add prefix to npm install commands if they don't already have one
    if [[ $cmd == "npm i"* || $cmd == "npm install"* ]] && [[ ! $cmd =~ --prefix ]]; then
      cmd="$cmd --prefix $LOCAL_DIR"
    fi
    if [[ $cmd == "go install"*  ]] && [[ ! $cmd =~ --GOBIN ]]; then
      cmd="GOBIN=$BIN_DIR $cmd"
    fi
    
    echo "[+] executing → $cmd"
    if ! eval "$cmd" > /dev/null 2>&1; then
      echo "[!] error executing: $cmd"
    fi
  ) &
done

wait

echo "[✓] language servers installed and binaries linked to $BIN_DIR"
