softwareupdate --install-rosetta --agree-to-license

#install Brew and more app using Brew
source brew/brew.sh
brew bundle

echo PATH="$PATH=/opt/homebrew/bin" >> .zshrc

# Cloning vim config & plugins
echo " ******* instaling mcp-hub *********"
echo " ******* instaling mcp-hub *********"
npm install -g mcp-hub


echo " ******** Cloning tmux plugins ********* "
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

launchctl load -w ~/Library/LaunchAgents/io.arslan.dark-mode-notify.plist

echo "/opt/homebrew/bin/fish" | sudo tee -a /etc/shells > /dev/null

sudo chsh -s /opt/homebrew/bin/fish
fish_add_path /opt/homebrew/bin

# Setup tide prompt
tide configure

echo " ********* enable dark mode notify service ********* "
gh auth login

gh repo clone EddCode/nvimrc ~/nvim
ln -sf  ~/nvim ~/.config/nvim

yabai --start-service
sdkh --start-service
