# Setting up development enviroment

## Description

This repository contains a set of configurations to install a development environment intended for osx systems and designed to use [Vim(8) plugins with the native pack system](https://medium.com/@paulodiovani/installing-vim-8-plugins-with-the-native-pack-system-39b71c351fea).


#### Tools
* [Fish shell](https://fishshell.com)
* [Fisher](https://github.com/jorgebucaran/fisher)
* [Hombrew](https://brew.sh)
* [Tmux](https://github.com/tmux/tmux/wiki)
* [Vim plugins 8]((https://medium.com/@paulodiovani/installing-vim-8-plugins-with-the-native-pack-system-39b71c351fea)

### Installing
In the repository there is a Makefile file, this will be in charge of executing all the configurations of each tool. (*_Remember that this configuration is designed to run on mac os systems_*).
```sh
  $ make
```


## Omarchy (Linux)
The same `make` works on [Omarchy](https://omarchy.org): the Makefile detects the system with `uname` and links only what applies. macOS files stay at the repo root, Omarchy ones live in `omarchy/`.

* `omarchy/hypr` → `~/.config/hypr` (Hyprland, linked file by file)
* `omarchy/omarchy/shell.json` → `~/.config/omarchy/shell.json` (bar layout, idle)
* `omarchy/alacritty/alacritty.toml` → `~/.config/alacritty/alacritty.toml`
* `omarchy/install.sh` installs tpm, clones [EddCode/nvimrc](https://github.com/EddCode/nvimrc) into `~/.config/nvim` and sets Firefox Developer Edition as default browser

Existing files are kept as `*.bak.<timestamp>` before linking. `omarchy bar ...` replaces the `shell.json` symlink with a regular file; run `make adopt` to copy it back into the repo. The bar uses the [omarchy-pods](https://github.com/thisisgm/omarchy-pods) plugin, which is installed separately.

### Window management keys
The same keys work on both systems: `omarchy/hypr/bindings.lua` for Hyprland (on top of Omarchy's default `SUPER` bindings) and `aerospace.toml` for [AeroSpace](https://github.com/nikitabobko/AeroSpace) on macOS, where `super` is `cmd`. A Mac still running yabai and skhd is switched over with `make migrate-aerospace`, which stops and uninstalls both, removes their configs and installs AeroSpace.

On macOS, `alt + 1..9` also switches workspace, `shift + alt + x` is unbound, and floating windows are not resized or centered.

| Keys | Action |
|---|---|
| `alt + h/j/k/l` | Focus window |
| `shift + alt + h/j/k/l` | Swap window |
| `ctrl + alt + h/j/k/l` | Move window and split |
| `shift + alt + r` | Rotate split |
| `shift + alt + y` / `x` | Flip split sides / orientation |
| `shift + alt + t` | Toggle float, centered at half size |
| `shift + alt + p` / `n` | Move window to previous / next workspace |
| `shift + alt + 1..9` | Move window to workspace |
| `super + ctrl + alt + h/j/k/l` | Focus monitor |
| `super + ctrl + alt + arrows` | Move window to monitor |
| `ctrl + alt + r` | Reload Hyprland |

## Hombrew
`brew.sh` file install homebrew if isnt installed and install some utiliies and cask.

*Some Homebrew formulas*
* GIT
* Nodejs
* [Neovim](https://neovim.io)
* [Tmux](https://github.com/tmux/tmux/wiki)
* [GH github cli](https://cli.github.com)
* [Fish shell](https://fishshell.com)
* *homebrew/cask-fonts*
  * [font-firaCode-nerd-fon](https://github.com/ryanoasis/nerd-fonts#font-installation)
  * [Victor Mono](https://rubjo.github.io/victor-mono/)
* *caskroom/cask*
  * [Docker](https://www.docker.com)
  * [insomnia](https://www.postman.com/product/api-client/)
  * [Iterm2](https://iterm2.com)

## Fish
Set a fish shell as a default shell and install *[fisher](https://github.com/jorgebucaran/fisher)* to handle `nvm`
and set a vim as default editor

## TMUX
Change a key bind action to `<C-t>` and also has an integration with N/vim. It also includes some utilities to be able to change the themes of tmux and vim between dark and light mode

## Vim
Download repository wich has a some vimrc configs and a some plugins
* to see wich plugins and configuration has it, take a look [EddCode/vimrc](https://github.com/EddCode/vimrc)
