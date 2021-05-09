#!/usr/bin/env bash

# Install Homebrew (if not installed)
if test ! $(which brew)
then
    echo "Installing Homebrew for you."

    # Install the correct homebrew for each OS type
    if test "$(uname)" = "Darwin"
    then
       ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    elif test "$(expr substr $(uname -s) 1 5)" = "Linux"
    then
        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install)"
    fi
fi

# Make sure we're using the latest Homebrew.
echo "Update & uhrade homebrew"
brew update

# Upgrade any already-installed formulae.
brew upgrade

# Save Homebrew's installed location.
BREW_PREFIX=$(brew --prefix)

brew install git

# Install `wget` with IRI support.
echo "Installing node"
brew install node
brew install yarn
brew install watchman

echo "Installing go(lang)"
brew install go

# Install fish shell and fisherman
echo "Install fish and set fish as default shell"
brew install fish

# Install other useful binaries.
echo "Install useful binaries"
brew install tmux
brew install node

# Installs Casks
brew tap homebrew/cask
brew tap homebrew/cask-fonts

# Install font tools.
brew cask install font-fira-code-nerd-font

## Apps I use
brew cask install docker
brew cask install lastpass
brew cask install microsoft-edge
brew cask install postman

echo "Installing Dart"
brew tap dart-lang/dart
brew install dart


