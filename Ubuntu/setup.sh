#- one short full tool set:-

#!/usr/bin/env bash
set -e

echo "🚀 Updating system..."
sudo apt update && sudo apt upgrade -y

echo "📦 Installing core build tools..."
sudo apt install -y build-essential curl wget git unzip zip software-properties-common

echo "🐍 Installing Python + tools..."
sudo apt install -y python3 python3-pip python3-venv

echo "🟩 Installing Node.js (LTS)..."
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt install -y nodejs

echo "☕ Installing Java (OpenJDK 17)..."
sudo apt install -y openjdk-17-jdk

echo "🐳 Installing Docker..."
sudo apt install -y ca-certificates gnupg lsb-release
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
  sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) \
  signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
sudo usermod -aG docker $USER

echo "🌐 Networking & diagnostics tools..."
sudo apt install -y net-tools iputils-ping dnsutils traceroute nmap tcpdump wireshark

echo "🧰 Dev utilities..."
sudo apt install -y htop tmux tree jq ripgrep fd-find fzf

echo "🧪 Optional: VS Code (from Microsoft repo)..."
sudo apt install -y apt-transport-https
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
echo "deb [arch=amd64,arm64,armhf] https://packages.microsoft.com/repos/code stable main" | \
  sudo tee /etc/apt/sources.list.d/vscode.list
sudo apt update
sudo apt install -y code

echo "🧹 Cleaning up..."
sudo apt autoremove -y

echo "✅ Done! Reboot or log out/in to use Docker without sudo."


#-how to run:-

chmod +x setup.sh
./setup.sh