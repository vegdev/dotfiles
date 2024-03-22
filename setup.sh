#!/usr/bin/env bash

install_dev() {
  sudo apt update
  sudo apt install -y build-essential git vim wget curl ripgrep find-fd virtualbox vagrant

  # nvm
  wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash
  export NVM_DIR="${XDG_CONFIG_HOME/:-$HOME/.}nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
 
  # neovim 
  source $(pwd)/script/neovim-install.sh
  source $(pwd)/script/neovim-setup

  # packer - package manager for neovim
  git clone --depth 1 https://github.com/wbthomason/packer.nvim\
  ~/.local/share/nvim/site/pack/packer/start/packer.nvim
  nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
}

install_gui() {
  sudo apt install terminator software-properties-common apt-transport-https
  # CHROME
  wget https://dl-ssl.google.com/linux/linux_signing_key.pub -O /tmp/google.pub
  gpg --no-default-keyring --keyring /etc/apt/keyrings/google-chrome.gpg --import /tmp/google.pub
  echo 'deb [arch=amd64 signed-by=/etc/apt/keyrings/google-chrome.gpg] http://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list
  sudo apt-get update
  sudo apt-get install google-chrome-stable
  google-chrome-stable --version

  # VS CODE
  wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
  sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
  sudo apt install code
  code --version
}

# Start Setup

echo "Setup Initiated..."
echo "Install for headless server or GUI?"
# create the menu for setup
options=("Server Only" "Server & GUI")
select option in "${option[@]}"; do
  case $REPLY in
    1)
      install_dev
      break
      ;;
    2)
      install_dev
      install_gui
      break
      ;;
    *)
      echo "Invalid option"
  esac
done
