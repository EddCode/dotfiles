#install Brew and more app using Brew
source brew/brew.sh

# Install fish plugins and set my config file
echo "Moving config.fish"
ln -sf ./fish/config.fish $HOME/.config/fish/config.fish
echo "Movin fish_prompt_config.fish"
ln -sf ./fish/fish_propmpt.fish $HOME/.config/fish/functions/fish_prompt.fish
ln -sf ./.gitconfig $HOME/.gitconfig

# Cloning vim config & plugins
echo "Cloning vim repositories"
git clone --recursive https://github.com/EddCode/vimrc.git ~/.dotvim

echo "Intalling vim config files"
ln -sf $HOME/.dotvim/.vimrc $HOME/.vimrc
ln -sf $HOME/.dotvim $HOME/.vim


# Install my tmux config file 
ln -sf ./tmux/.tmux.conf $HOME/.tmux.conf

# Install nvm
echo "Installing NVM"
mkdir $HOME/.nvm
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
mkdir .config/fish/functions/nvm.fish

ln -sf $HOME/.dotfiles/fish/nvm.fish $HOME/.config/fish/functions/nvm.fish
ln -sf $HOME/.dotfiles/fish/config.fish $HOME/.config/fish/functions/config.fish
ln -sf $HOME/.dotfile/fish/fish.fish $HOME/.config/fish/functions/fish.fish
ln -sf $HOME/.dotfile/fish/fish_prompt.fish $HOME/.config/fish/functions/fish_prompt.fish

