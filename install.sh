#install Brew and more app using Brew
source brew/brew.sh

# Install fish plugins and set my config file
echo "Moving config.fish"
ln -sf ./fish/config.fish $HOME/.config/fish/config.fish
echo "Movin fish_prompt_config.fish"
ln -s ./fish/fish_propmpt.fish $HOME/.config/fish/functions/fish_prompt.fish

# Cloning vim config & plugins
echo "Cloning vim repositories"
git clone --recursive https://github.com/EddCode/vimrc.git ~/.dotvim

echo "Intalling vim config files"
ln -sf $HOME/.dotvim/.vimrc $HOME/.vimrc
ln -sf $HOME/.dotfiles $HOME/.vim


# Install my tmux config file 
ln -sf ./tmux/.tmux.conf $HOME/.tmux.conf

# Install nvm
echo "Installing NVM"
mkdir $HOME/.nvm
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
mkdir .config/fish/functions/nvm.fish

ln -sf ./fish/nvm.fish $HOME/.config/fish/functions/nvm.fish
