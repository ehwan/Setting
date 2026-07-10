#! /bin/bash

SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)

sudo -v

sudo apt update
sudo apt install build-essential -y
sudo apt install zsh -y
sudo apt install neovim -y
sudo apt install python3 python3-venv python3-pip -y

sudo -k

chsh -s $(which zsh)

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