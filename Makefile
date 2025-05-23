all: sync

sync:
	mkdir -p ~/.config/alacritty
	mkdir -p ~/.config/fish
	mkdir -p ~/.config/fish/functions
	mkdir -p ~/.config/nvim
	mkdir -p ~/.config/yabai
	mkdir -p ~/.config/skhd
	mkdir -p ~/.tmux/
	mkdir -p ~/Library/LaunchAgents

	ln -sf $(PWD)/fish/alacritty-theme.fish ~/.config/fish/functions/alacritty-theme.fish
	ln -sf $(PWD)/fish/change_background.fish ~/.config/fish/functions/change_background.fish
	ln -sf $(PWD)/fish/fish.fish ~/.config/fish/functions/fish.fish
	ln -sf $(PWD)/fish/removepath ~/.config/fish/functions/removepath.fish
	ln -sf $(PWD)/fish/functions/fish_prompt.fish ~/.config/fish/functions/fish_prompt.fish
	ln -sf $(PWD)/fish/config.fish ~/.config/fish/config.fish
	ln -sf ${pwd}/fish/fnm.fish ~/.config/fish/conf.d/fnm.fish

	ln -sf $(PWD)/editorconfig ~/.editorconfig
	ln -sf $(PWD)/gitconfig ~/.gitconfig
	ln -sf $(PWD)/yabairc ~/.config/yabai/yabairc
	ln -sf $(PWD)/skhdrc ~/.config/skhd/skhdrc

	ln -sf $(PWD)/tmux/tmux.conf ~/.tmux.conf
	ln -sf $(PWD)/tmux/dark.conf ~/.tmux/tmux-dark.conf
	ln -sf $(PWD)/tmux/light.conf ~/.tmux/tmux-light.conf

	ln -sf $(PWD)/alacritty.yml ~/.config/alacritty/alacritty.yml
	ln -sf $(PWD)/color.yml ~/.config/alacritty/color.yml
	ln -sf $(PWD)/io.arslan.dark-mode-notify.plist ~/Library/LaunchAgents/io.arslan.dark-mode-notify.plist

	sh install.sh

clean:
	rm -f ~/.config/alacritty/alacritty.yml
	rm -f ~/.config/alacritty/color.yml
	rm -f ~/.config/fish/config.fish
	rm -f ~/.config/nvim/init.vim
	rm -rf ~/.dotvim
	rm -rf ~/.vim
	rm -r ~/.vimrc
	rm -f ~/.tmux.conf
	rm -f ~/.gitconfig
	rm -f ~/Library/LaunchAgents/io.arslan.dark-mode-notify.plist

.PHONY: all clean sync
