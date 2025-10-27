all: sync

sync: link install

install:
	@echo "Installing plugins and fonts"
	sh install.sh

link:
	@echo "Creating simbolic links"
	ln -sf $(PWD)/fish ~/.config/fish

	ln -sf $(PWD)/editorconfig ~/.editorconfig
	ln -sf $(PWD)/gitconfig ~/.gitconfig
	ln -sf $(PWD)/yabairc ~/.config/yabai/yabairc
	ln -sf $(PWD)/skhdrc ~/.config/skhd/skhdrc

	ln -sf $(PWD)/tmux/tmux.conf ~/.tmux.conf

	ln -sf $(PWD)/alacritty.yml ~/.config/alacritty/alacritty.yml
	ln -sf $(PWD)/color.yml ~/.config/alacritty/color.yml
	ln -sf $(PWD)/io.arslan.dark-mode-notify.plist ~/Library/LaunchAgents/io.arslan.dark-mode-notify.plist

clean:
	unlink ~/.editorconfig
	unlink ~/.gitconfig
	unlink ~/.config/*
	unlink ~/.config/alacritty/alacritty.yml
	unlink ~/.config/alacritty/color.yml
	unlink ~/Library/LaunchAgents/io.arslan.dark-mode-notify.plist



.PHONY: all sync
