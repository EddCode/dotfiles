softwareupdate --install-rosetta --agree-to-license

#install Brew and more app using Brew
source brew/brew.sh

brew bundle

# Cloning vim config & plugins
echo " ********* Cloning vim repositories ********* "
git clone --recursive https://github.com/EddCode/vimrc.git ~/.dotvim

echo " ********* Setting up fish and fisher ********* "
curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish
sudo chsh -s /opt/homebrew/bin/fish
fish_add_path /opt/homebrew/bin

# Install nvm
echo " ********* Installing NVM ********* "
omf install nvm

echo " ******** Cloning tmux plugins ********* "
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

launchctl load -w ~/Library/LaunchAgents/io.arslan.dark-mode-notify.plist

echo " ********* enable dark mode notify service ********* "
gh auth login

# Setup tide prompt
tide configure
