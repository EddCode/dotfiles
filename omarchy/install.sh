#!/bin/sh

# Omarchy-only setup. Run through `make install` (or `make`) from the repo root.

echo " ******** Cloning tmux plugins ********* "
if [ ! -d ~/.tmux/plugins/tpm ]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

echo " ******** Cloning nvim config ********* "
nvim_dir=~/.config/nvim
if git -C $nvim_dir remote get-url origin 2>/dev/null | grep -q 'EddCode/nvimrc'; then
  echo "nvim config already cloned in $nvim_dir"
else
  # Keep whatever is there (Omarchy ships its own nvim config) as a backup.
  if [ -e $nvim_dir ] || [ -L $nvim_dir ]; then
    mv $nvim_dir $nvim_dir.bak.$(date +%s)
  fi
  git clone git@github.com:EddCode/nvimrc.git $nvim_dir ||
    git clone https://github.com/EddCode/nvimrc.git $nvim_dir
fi

echo " ******** Setting default browser ********* "
browser=firefox-developer-edition.desktop
if [ -f /usr/share/applications/$browser ] || [ -f ~/.local/share/applications/$browser ]; then
  xdg-settings set default-web-browser $browser
  for mime in text/html application/xhtml+xml x-scheme-handler/http x-scheme-handler/https x-scheme-handler/about x-scheme-handler/unknown; do
    xdg-mime default $browser $mime
  done
else
  echo "$browser is not installed, keeping the current default browser"
fi

echo " ******** Reloading Hyprland ********* "
if [ -n "$HYPRLAND_INSTANCE_SIGNATURE" ]; then
  hyprctl reload
  hyprctl configerrors
fi
