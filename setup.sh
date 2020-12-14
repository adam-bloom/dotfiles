#!/bin/sh

# If we on macOS, install homebrew and tweak system a bit.
if [[ `uname` == 'Darwin' ]]; then
  which -s brew
  if [[ $? != 0 ]]; then
    echo 'Installing Homebrew...'
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  fi

  # Homebrew packages.
  brew install iterm2 visual-studio-code sublime-text
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

# install fonts
curl -fsSL -o "$HOME/Library/Fonts/DejaVu Sans Mono Nerd Font Complete Mono.ttf" https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/patched-fonts/DejaVuSansMono/Regular/complete/DejaVu%20Sans%20Mono%20Nerd%20Font%20Complete%20Mono.ttf
curl -fsSL -o "$HOME/Library/Fonts/DejaVu Sans Mono Nerd Font Complete.ttf" https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/patched-fonts/DejaVuSansMono/Regular/complete/DejaVu%20Sans%20Mono%20Nerd%20Font%20Complete.ttf
curl -fsSL -o "$HOME/Library/Fonts/DejaVu Sans Mono Oblique Nerd Font Complete Mono.ttf" https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/patched-fonts/DejaVuSansMono/Italic/complete/DejaVu%20Sans%20Mono%20Oblique%20Nerd%20Font%20Complete%20Mono.ttf
curl -fsSL -o "$HOME/Library/Fonts/DejaVu Sans Mono Oblique Nerd Font Complete.ttf" https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/patched-fonts/DejaVuSansMono/Italic/complete/DejaVu%20Sans%20Mono%20Oblique%20Nerd%20Font%20Complete.ttf
curl -fsSL -o "$HOME/Library/Fonts/DejaVu Sans Mono Bold Nerd Font Complete Mono.ttf" https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/patched-fonts/DejaVuSansMono/Bold/complete/DejaVu%20Sans%20Mono%20Bold%20Nerd%20Font%20Complete%20Mono.ttf
curl -fsSL -o "$HOME/Library/Fonts/DejaVu Sans Mono Bold Nerd Font Complete.ttf" https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/patched-fonts/DejaVuSansMono/Bold/complete/DejaVu%20Sans%20Mono%20Bold%20Nerd%20Font%20Complete.ttf
curl -fsSL -o "$HOME/Library/Fonts/DejaVu Sans Mono Bold Oblique Nerd Font Complete Mono.ttf" https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/patched-fonts/DejaVuSansMono/Bold-Italic/complete/DejaVu%20Sans%20Mono%20Bold%20Oblique%20Nerd%20Font%20Complete%20Mono.ttf
curl -fsSL -o "$HOME/Library/Fonts/DejaVu Sans Mono Bold Oblique Nerd Font Complete.ttf" https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/patched-fonts/DejaVuSansMono/Bold-Italic/complete/DejaVu%20Sans%20Mono%20Bold%20Oblique%20Nerd%20Font%20Complete.ttf

# setup zsh
ln -sf "$(pwd)/zsh/zshrc" "$HOME/.zshrc"
ln -sf "$(pwd)/zsh/p10k.zsh" "$HOME/.p10k.zsh"

# setup iterm2
defaults write com.googlecode.iterm2 PrefsCustomFolder -string "$(pwd)/iterm2"

# setup vscode...must already be installed and `code` executable must be in path
ln -sf "$(pwd)/vscode/settings.json" "$HOME/Library/Application Support/Code/User/settings.json"
code --install-extension zehfernando.theme-actual-obsidian
code --install-extension ms-python.python
code --install-extension ms-vscode.cpptools

# sublime text settings
ln -sf "$(pwd)/sublime_text/Preferences.sublime-settings" "$HOME/Library/Application Support/Sublime Text 3/Packages/User/Preferences.sublime-settings"
ln -sf "$(pwd)/sublime_text/Python.sublime-settings" "$HOME/Library/Application Support/Sublime Text 3/Packages/User/Python.sublime-settings"
