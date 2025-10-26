git clone https://github.com/ehwan/Setting.git

sudo apt update
sudo apt install build-essential -y
sudo apt install zsh -y

sudo passwd ubuntu
chsh -s $(which zsh)


sudo apt install ufw -y
sudo ufw allow 21114:21119/tcp
sudo ufw allow 21116/udp
sudo ufw allow 22/tcp
sudo ufw enable

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

cargo install lsd
cargo install starship


bash <(wget -qO- https://get.docker.com)
wget rustdesk.com/oss.yml -O compose.yml
sudo docker compose up -d
