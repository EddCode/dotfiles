softwareupdate --install-rosetta --agree-to-license

#install Brew and more app using Brew
source brew/brew.sh

brew bundle

echo PATH="$PATH=/opt/homebrew/bin" >> .zshrc

# Cloning vim config & plugins
echo " ********* Cloning vim repositories ********* "
git clone --recursive https://github.com/EddCode/vimrc.git ~/.dotvim

ln -sf ~/.dotvim/.vimrc ~/.vimrc
ln -sf ~/.dotvim ~/.vim

echo " ******** Cloning tmux plugins ********* "
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

launchctl load -w ~/Library/LaunchAgents/io.arslan.dark-mode-notify.plist

echo " ********* Setting up fish and fisher ********* "
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
fisher install IlanCosman/tide@v6

sudo chsh -s /opt/homebrew/bin/fish
fish_add_path /opt/homebrew/bin

# Setup tide prompt
tide configure

echo " ********* enable dark mode notify service ********* "
gh auth login

