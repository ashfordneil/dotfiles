#!/usr/bin/env sh

# Sanity check to make sure we aren't about to create a bunch of broken symlinks
if [ `pwd` != "$HOME/.config/dotfiles" ] || [ $0 != "./install.sh" ]; then
  echo 'Please clone the dotfiles repo to $HOME/.config/dotfiles and run the script from within that directory'
  exit 1
fi

# Install brew if it isn't there
if [ ! -x /usr/local/bin/brew ]; then
  echo 'Homebrew not found, installing homebrew'
  bash -c $(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)
fi

# Install some useful things to get the most out of the rest of the dotfiles
brew install \
  zplug \
  neovim \
  iterm2 \
  starship \
  fzy \


# Set up symlinks to config files
if [ ! -L "$HOME/.config/starship.toml" ]; then
  ln -s dotfiles/starship.toml starship.toml
fi

if [ ! -d "$HOME/.config/nvim" ]; then
  mkdir -p "$HOME/.config/nvim"
  ln -s ../dotfiles/init.lua ../dotfiles/lua "$HOME/.config/nvim"
fi

if [ ! -L "$HOME/.zshrc" ]; then
  ln -s .config/dotfiles/rz.zch "$HOME/.zshrc"
fi
