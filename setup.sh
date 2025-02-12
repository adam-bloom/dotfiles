#!/bin/bash

# If we on macOS, install homebrew and tweak system a bit.
if [[ `uname` == 'Darwin' ]]; then
  which -s brew
  if [[ $? != 0 ]]; then
    echo 'Installing Homebrew...'
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  fi

  # Homebrew packages.
  brew install iterm2 visual-studio-code
  brew tap homebrew/command-not-found
fi

export OH_MY_ZSH_DIR=~/.oh-my-zsh

if [ ! -d $OH_MY_ZSH_DIR ]; then
  git clone https://github.com/robbyrussell/oh-my-zsh.git $OH_MY_ZSH_DIR
fi

ZSH_THEME_P10K_DIR=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k
if [ ! -d "$ZSH_THEME_P10K_DIR" ]; then
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$ZSH_THEME_P10K_DIR"
fi

ZSH_PLUGIN_SYN_HIGHLIGHT_DIR=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
if [ ! -d "$ZSH_PLUGIN_SYN_HIGHLIGHT_DIR" ]; then
  git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_PLUGIN_SYN_HIGHLIGHT_DIR"
fi

ZSH_PLUGIN_AUTOSUGGEST_DIR=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
if [ ! -d "$ZSH_PLUGIN_AUTOSUGGEST_DIR" ]; then
  git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions.git "$ZSH_PLUGIN_AUTOSUGGEST_DIR"
fi

# install fonts
font_dir=$(mktemp -d)
pushd .
cd $font_dir
curl -fsSL -o ./dejavu.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/DejaVuSansMono.zip
unzip ./dejavu.zip
cp ./*.ttf "$HOME/Library/Fonts/."
popd
rm -r $font_dir

# setup zsh
ln -sf "$(pwd)/zsh/zshrc" "$HOME/.zshrc"
ln -sf "$(pwd)/zsh/p10k.zsh" "$HOME/.p10k.zsh"

# continue with iterm/editor setup on macOS only
if [[ `uname` == 'Darwin' ]]; then
  # setup iterm2
  defaults write com.googlecode.iterm2 PrefsCustomFolder -string "$(pwd)/iterm2"
  defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder --bool TRUE

  # setup vscode...must already be installed and `code` executable must be in path
  ln -sf "$(pwd)/vscode/settings.json" "$HOME/Library/Application Support/Code/User/settings.json"
  code --install-extension zehfernando.theme-actual-obsidian
  code --install-extension ms-python.python
  code --install-extension ms-vscode.cpptools
fi
