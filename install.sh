#

# Idempotent dotfiles installer for macOS and Linux.
# Creates symlinks for all config files and scripts safely and recursively.

set -euo pipefail

# Determine the directory where this script is located
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BIN_DIR="$HOME/.local/bin"
CONFIG_DIR="$HOME/.config"

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RESET='\033[0m'

info() { echo -e "${GREEN}==>${RESET} $1"; }
warn() { echo -e "${YELLOW}⚠ $1${RESET}"; }

# --- Safe symlink creation (idempotent) ---
link_file() {
    local src=$1
    local dest=$2

    mkdir -p "$(dirname "$dest")"

    if [ -L "$dest" ]; then
        if [ "$(readlink "$dest")" = "$src" ]; then
            info "Symlink already correct: $dest"
        else
            warn "Symlink points elsewhere, updating: $dest"
            ln -sf "$src" "$dest"
        fi
    elif [ -e "$dest" ]; then
        warn "Backing up existing file: $dest -> ${dest}.bak"
        mv "$dest" "${dest}.bak"
        ln -s "$src" "$dest"
        info "Created new symlink: $dest -> $src"
    else
        ln -s "$src" "$dest"
        info "Created symlink: $dest -> $src"
    fi
}

# --- Recursively link all files in a directory ---
link_directory() {
    local src_dir=$1
    local dest_dir=$2

    find "$src_dir" -mindepth 1 -type f | while read -r file; do
        local rel_path="${file#$src_dir/}"
        link_file "$file" "$dest_dir/$rel_path"
    done
}

# --- Detect platform ---
OS="$(uname -s)"
case "$OS" in
    Darwin) PLATFORM="macOS" ;;
    Linux)  PLATFORM="Linux" ;;
    *)      PLATFORM="Unknown" ;;
esac

info "Detected system: $PLATFORM"
info "Dotfiles directory: $DOTFILES_DIR"

# --- ZSH (files directly in home) ---
link_directory "$DOTFILES_DIR/zsh" "$HOME"

# --- Neovim (everything in ~/.config/nvim) ---
link_directory "$DOTFILES_DIR/nvim" "$CONFIG_DIR/nvim"

# --- Tmux (files directly in home) ---
link_directory "$DOTFILES_DIR/tmux" "$HOME"

# --- Scripts (flat structure) ---
mkdir -p "$BIN_DIR"
for script in "$DOTFILES_DIR/scripts/"*; do
    [ -f "$script" ] || continue
    chmod +x "$script"
    link_file "$script" "$BIN_DIR/$(basename "$script")"
done

info "✅ Installation complete!"
