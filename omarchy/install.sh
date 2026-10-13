#!/bin/sh

# Omarchy-only setup. Run through `make install` (or `make`) from the repo root.

echo " ******** Cloning tmux plugins ********* "
if [ ! -d ~/.tmux/plugins/tpm ]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
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
