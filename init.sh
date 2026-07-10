#! /bin/bash

SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)

if [ "$(uname)" = "Linux" ]; then
    if [ -f /etc/os-release ]; then
        # Check if the OS is Ubuntu or Debian
        OS_ID=$(. /etc/os-release && echo "$ID")
    else
        OS_ID="unknown"
    fi

    if [ "$OS_ID" != "ubuntu" ] && [ "$OS_ID" != "debian" ]; then
        echo "Error: This script can only be run on Ubuntu/Debian systems." >&2
        exit 1
    fi

    if ! command -v apt >/dev/null 2>&1; then
        echo "Error: This script requires the 'apt' package manager." >&2
        exit 1
    fi


    sudo -v

    sudo apt update
    sudo apt install build-essential -y
    sudo apt install zsh -y
    sudo apt install neovim -y
    sudo apt install python3 python3-venv python3-pip -y

    sudo -k

    chsh -s $(which zsh)
elif [ "$(uname)" = "Darwin" ]; then
    if [ -z "$ZSH_VERSION" ] && [ "$(basename "$SHELL")" != "zsh" ]; then
        echo "Error: This script can only be run in a zsh environment." >&2
        exit 1
    fi

    # Check if Homebrew is installed
    if ! command -v brew >/dev/null 2>&1; then
        echo "Error: Homebrew is not installed or not in PATH." >&2
        exit 1
    fi

    brew update

    brew install --non-interactive neovim
    # brew install --non-interactive python
fi

mkdir -p "$HOME/.config/nvim"
mkdir -p "$HOME/.config/nvim/autoload"
ln -s "$SCRIPT_DIR/init.vim" "$HOME/.config/nvim/init.vim"
sh -c 'curl -fLo "$HOME/.config/nvim/site/autoload/plug.vim" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

mkdir -p "$HOME/.ssh"
ln -s "$SCRIPT_DIR/ssh_config" "$HOME/.ssh/config"

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source "$HOME/.cargo/env"
cargo install lsd
cargo install starship
cargo install rustylr

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
echo "source $SCRIPT_DIR/myzshrc.sh" >> "$HOME/.zshrc"