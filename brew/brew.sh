#!/bin/sh

# Install Homebrew (if not installed)
if ! command -v brew &> /dev/null; then
    	echo "Installing Homebrew for you."
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

	export PATH="/opt/homebrew/bin:$PATH" 
else
    	echo "Homebrew is already installed. Updating brew for you."
	# Make sure we're using the latest Homebrew.
	echo "Update & uhrade homebrew"
	brew update

	# Upgrade any already-installed formulae.
	brew upgrade
fi
