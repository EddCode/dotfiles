DOTFILES := $(CURDIR)
UNAME := $(shell uname -s)
CONFIG := $(HOME)/.config

# Link $(1) to $(2), keeping any real file already there as a .bak.
define link
	@mkdir -p $(dir $(2))
	@if [ -e $(2) ] && [ ! -L $(2) ]; then mv $(2) $(2).bak.$$(date +%s); fi
	ln -sfn $(1) $(2)
endef

# Remove $(1) only when it is a symlink.
define unlink
	@if [ -L $(1) ]; then unlink $(1); fi
endef

HYPR_FILES := hyprland.lua bindings.lua input.lua looknfeel.lua monitors.lua autostart.lua hyprsunset.conf xdph.conf

ifeq ($(UNAME),Darwin)
OS := macos
GITCONFIG := $(HOME)/.gitconfig
TMUXCONF := $(HOME)/.tmux.conf
else
OS := omarchy
GITCONFIG := $(CONFIG)/git/config
TMUXCONF := $(CONFIG)/tmux/tmux.conf
endif

all: sync

sync: link install

install: install-$(OS)

install-macos:
	@echo "Installing plugins and fonts"
	sh install.sh

install-omarchy:
	@echo "Setting up Omarchy"
	sh omarchy/install.sh

link: link-common link-$(OS)

link-common:
	@echo "Creating simbolic links"
	$(call link,$(DOTFILES)/fish,$(CONFIG)/fish)
	$(call link,$(DOTFILES)/editorconfig,$(HOME)/.editorconfig)
	$(call link,$(DOTFILES)/gitconfig,$(GITCONFIG))
	$(call link,$(DOTFILES)/claude/agents,$(HOME)/.claude/agents)
	$(call link,$(DOTFILES)/tmux/tmux.conf,$(TMUXCONF))

link-macos:
	$(call link,$(DOTFILES)/yabairc,$(CONFIG)/yabai/yabairc)
	$(call link,$(DOTFILES)/skhdrc,$(CONFIG)/skhd/skhdrc)
	$(call link,$(DOTFILES)/alacritty.yml,$(CONFIG)/alacritty/alacritty.yml)
	$(call link,$(DOTFILES)/color.yml,$(CONFIG)/alacritty/color.yml)
	$(call link,$(DOTFILES)/io.arslan.dark-mode-notify.plist,$(HOME)/Library/LaunchAgents/io.arslan.dark-mode-notify.plist)

link-omarchy:
	$(foreach file,$(HYPR_FILES),$(call link,$(DOTFILES)/omarchy/hypr/$(file),$(CONFIG)/hypr/$(file))$(newline))
	$(call link,$(DOTFILES)/omarchy/omarchy/shell.json,$(CONFIG)/omarchy/shell.json)
	$(call link,$(DOTFILES)/omarchy/alacritty/alacritty.toml,$(CONFIG)/alacritty/alacritty.toml)

# Omarchy commands such as `omarchy bar ...` rewrite shell.json in place of the
# symlink. This copies the rewritten file back into the repo and relinks it.
adopt:
	@if [ -f $(CONFIG)/omarchy/shell.json ] && [ ! -L $(CONFIG)/omarchy/shell.json ]; then \
		mv $(CONFIG)/omarchy/shell.json $(DOTFILES)/omarchy/omarchy/shell.json; \
		ln -sfn $(DOTFILES)/omarchy/omarchy/shell.json $(CONFIG)/omarchy/shell.json; \
		echo "Adopted shell.json"; \
	fi

clean: clean-common clean-$(OS)

clean-common:
	$(call unlink,$(CONFIG)/fish)
	$(call unlink,$(HOME)/.editorconfig)
	$(call unlink,$(GITCONFIG))
	$(call unlink,$(HOME)/.claude/agents)
	$(call unlink,$(TMUXCONF))

clean-macos:
	$(call unlink,$(CONFIG)/yabai/yabairc)
	$(call unlink,$(CONFIG)/skhd/skhdrc)
	$(call unlink,$(CONFIG)/alacritty/alacritty.yml)
	$(call unlink,$(CONFIG)/alacritty/color.yml)
	$(call unlink,$(HOME)/Library/LaunchAgents/io.arslan.dark-mode-notify.plist)

clean-omarchy:
	$(foreach file,$(HYPR_FILES),$(call unlink,$(CONFIG)/hypr/$(file))$(newline))
	$(call unlink,$(CONFIG)/omarchy/shell.json)
	$(call unlink,$(CONFIG)/alacritty/alacritty.toml)

define newline


endef

.PHONY: all sync adopt install install-macos install-omarchy link link-common link-macos link-omarchy clean clean-common clean-macos clean-omarchy
