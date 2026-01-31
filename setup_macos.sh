#!/bin/bash

# macOS Setup Script
# This script installs all required tools and applications for the dotfiles

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

print_status() {
    echo -e "${BLUE}==>${NC} $1"
}

print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}!${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

# Check if running on macOS
if [[ "$(uname -s)" != "Darwin" ]]; then
    print_error "This script is only for macOS"
    exit 1
fi

print_status "Starting macOS setup..."

# ==============================================================================
# Homebrew
# ==============================================================================
print_status "Checking Homebrew..."

if ! command -v brew &>/dev/null; then
    print_status "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Add Homebrew to PATH for this session
    eval "$(/opt/homebrew/bin/brew shellenv)"
    print_success "Homebrew installed"
else
    print_success "Homebrew already installed"
fi

# Update Homebrew
print_status "Updating Homebrew..."
brew update

# ==============================================================================
# CLI Tools
# ==============================================================================
print_status "Installing CLI tools..."

CLI_TOOLS=(
    # Core utilities
    "git"
    "stow"
    "curl"
    "wget"

    # Modern CLI replacements
    "eza"     # Modern ls replacement
    "fd"      # Modern find replacement
    "ripgrep" # Modern grep replacement
    "fzf"     # Fuzzy finder
    "zoxide"  # Smart cd replacement

    # Development tools
    "neovim"     # Text editor
    "tmux"       # Terminal multiplexer
    "lazygit"    # Git TUI
    "lazydocker" # Docker TUI
    "lazysql"    # SQL TUI
    "sesh"       # Tmux session manager

    # Language version managers
    "nvm"        # Node version manager
    "rbenv"      # Ruby version manager
    "ruby-build" # rbenv plugin for installing Ruby versions
    "rustup"     # Rust toolchain installer
    "go"         # Go programming language
    "pipx"       # Python app installer

    # LSP servers & dev tools
    "lua-language-server"
    "bash-language-server"
    "gopls"
    "marksman"   # Markdown LSP
    "stylua"     # Lua formatter
    "shellcheck" # Shell linter
    "hadolint"   # Dockerfile linter
)

for tool in "${CLI_TOOLS[@]}"; do
    if brew list "$tool" &>/dev/null; then
        print_success "$tool already installed"
    else
        print_status "Installing $tool..."
        brew install "$tool" || print_warning "Failed to install $tool"
    fi
done

# ==============================================================================
# Cask Applications (GUI apps)
# ==============================================================================
print_status "Installing applications..."

CASK_APPS=(
    "ghostty"                   # Terminal emulator
    "kitty"                     # Alternative terminal
    "nikitabobko/tap/aerospace" # Tiling window manager
    "karabiner-elements"        # Keyboard customization
    "firefox"                   # Web browser
)

for app in "${CASK_APPS[@]}"; do
    app_name=$(echo "$app" | sed 's|.*/||') # Get app name from tap/name format
    if brew list --cask "$app_name" &>/dev/null 2>&1 || brew list "$app" &>/dev/null 2>&1; then
        print_success "$app_name already installed"
    else
        print_status "Installing $app_name..."
        brew install --cask "$app" 2>/dev/null || brew install "$app" || print_warning "Failed to install $app_name"
    fi
done

# ==============================================================================
# Fonts
# ==============================================================================
print_status "Installing fonts..."

# Add font cask tap
brew tap homebrew/cask-fonts 2>/dev/null || true

FONTS=(
    "font-jetbrains-mono-nerd-font"
)

for font in "${FONTS[@]}"; do
    if brew list --cask "$font" &>/dev/null; then
        print_success "$font already installed"
    else
        print_status "Installing $font..."
        brew install --cask "$font" || print_warning "Failed to install $font"
    fi
done

# ==============================================================================
# Tmux Plugin Manager (TPM)
# ==============================================================================
print_status "Setting up Tmux Plugin Manager..."

TPM_DIR="$HOME/.tmux/plugins/tpm"
if [[ ! -d "$TPM_DIR" ]]; then
    print_status "Installing TPM..."
    git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
    print_success "TPM installed"
else
    print_success "TPM already installed"
fi

# ==============================================================================
# Zinit (Zsh plugin manager)
# ==============================================================================
print_status "Setting up Zinit..."

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [[ ! -d "$ZINIT_HOME" ]]; then
    print_status "Installing Zinit..."
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
    print_success "Zinit installed"
else
    print_success "Zinit already installed"
fi

# ==============================================================================
# Node.js (via nvm)
# ==============================================================================
print_status "Setting up Node.js..."

export NVM_DIR="$HOME/.nvm"
mkdir -p "$NVM_DIR"

# Source nvm
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"

if command -v nvm &>/dev/null; then
    # Install latest LTS Node.js
    if ! nvm ls --no-colors | grep -q "lts"; then
        print_status "Installing Node.js LTS..."
        nvm install --lts
        nvm use --lts
        nvm alias default 'lts/*'
        print_success "Node.js LTS installed"
    else
        print_success "Node.js already installed"
    fi

    # Install global npm packages (LSP servers)
    print_status "Installing npm global packages..."
    NPM_PACKAGES=(
        "typescript"
        "typescript-language-server"
        "dockerfile-language-server-nodejs"
        "@prisma/language-server"
        "@tailwindcss/language-server"
        "yaml-language-server"
        "vscode-langservers-extracted" # JSON, HTML, CSS LSP
    )

    for pkg in "${NPM_PACKAGES[@]}"; do
        if npm list -g "$pkg" &>/dev/null; then
            print_success "$pkg already installed"
        else
            print_status "Installing $pkg..."
            npm install -g "$pkg" || print_warning "Failed to install $pkg"
        fi
    done
else
    print_warning "nvm not available in this session. Run 'source ~/.zshrc' and install Node.js manually"
fi

# ==============================================================================
# Rust
# ==============================================================================
print_status "Setting up Rust..."

if [[ ! -d "$HOME/.rustup" ]]; then
    print_status "Installing Rust via rustup..."
    rustup-init -y --no-modify-path
    source "$HOME/.cargo/env"
    print_success "Rust installed"
else
    print_success "Rust already installed"
fi

# ==============================================================================
# Ruby (via rbenv)
# ==============================================================================
print_status "Setting up Ruby..."

if command -v rbenv &>/dev/null; then
    eval "$(rbenv init - --no-rehash zsh)"

    # Install latest stable Ruby if not installed
    LATEST_RUBY=$(rbenv install -l 2>/dev/null | grep -v - | tail -1 | tr -d ' ')
    if [[ -n "$LATEST_RUBY" ]] && ! rbenv versions | grep -q "$LATEST_RUBY"; then
        print_status "Installing Ruby $LATEST_RUBY..."
        rbenv install "$LATEST_RUBY"
        rbenv global "$LATEST_RUBY"
        print_success "Ruby $LATEST_RUBY installed"
    else
        print_success "Ruby already installed"
    fi
else
    print_warning "rbenv not available"
fi

# ==============================================================================
# Stow Dotfiles
# ==============================================================================
print_status "Setting up dotfiles with stow..."

DOTFILES_DIR="$HOME/.dotfiles"
if [[ -d "$DOTFILES_DIR" ]]; then
    cd "$DOTFILES_DIR"

    # Create backup directory
    BACKUP_DIR="$HOME/.dotfiles-backup-$(date +%Y%m%d%H%M%S)"

    # Backup existing configs if they exist and are not symlinks
    CONFIG_FILES=(
        "$HOME/.zshrc"
        "$HOME/.config/nvim"
        "$HOME/.config/tmux"
        "$HOME/.config/ghostty"
        "$HOME/.config/kitty"
        "$HOME/.config/aerospace"
        "$HOME/.config/karabiner"
    )

    for file in "${CONFIG_FILES[@]}"; do
        if [[ -e "$file" && ! -L "$file" ]]; then
            mkdir -p "$BACKUP_DIR"
            print_warning "Backing up $file to $BACKUP_DIR"
            mv "$file" "$BACKUP_DIR/" 2>/dev/null || true
        fi
    done

    # Create .config directory if it doesn't exist
    mkdir -p "$HOME/.config"

    # Run stow
    print_status "Running stow..."
    stow -v --target="$HOME" . 2>&1 | head -20 || print_warning "Some stow conflicts may need manual resolution"

    print_success "Dotfiles linked"
else
    print_warning "Dotfiles directory not found at $DOTFILES_DIR"
fi

# ==============================================================================
# macOS Settings
# ==============================================================================
print_status "Configuring macOS settings..."

# Show hidden files in Finder
defaults write com.apple.finder AppleShowAllFiles -bool true

# Show path bar in Finder
defaults write com.apple.finder ShowPathbar -bool true

# Show status bar in Finder
defaults write com.apple.finder ShowStatusBar -bool true

# Disable press-and-hold for keys in favor of key repeat
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# Set fast key repeat rate
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15

# Disable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

print_success "macOS settings configured"

# ==============================================================================
# Summary
# ==============================================================================
echo ""
echo "=============================================="
print_success "Setup complete!"
echo "=============================================="
echo ""
echo "Next steps:"
echo "  1. Restart your terminal or run: source ~/.zshrc"
echo "  2. Run 'p10k configure' to setup Powerlevel10k prompt"
echo "  3. Open tmux and press 'prefix + I' to install tmux plugins"
echo "  4. Open Neovim - plugins will auto-install on first launch"
echo "  5. Grant permissions to AeroSpace and Karabiner in System Preferences"
echo ""
print_warning "Some changes require logging out or restarting to take effect"
