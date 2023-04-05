#!/bin/bash

set -eufo pipefail

echo ""
echo "🤚 This script will setup .dotfiles for you."
read -n 1 -r -s -p $'    Press any key to continue or Ctrl+C to abort...\n\n'

# Install Rosetta
softwareupdate --install-rosetta

# Install Homebrew
command -v brew >/dev/null 2>&1 || \
  (echo '🍺  Installing Homebrew' && /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)")
(echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> /Users/muntasir/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

# Install Oh My Zsh
if [ ! -f ~/.oh-my-zsh/oh-my-zsh.sh ]; then
  (echo '💰  Installing oh-my-zsh' && yes | sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)")
fi

# Install chezmoi
command -v chezmoi >/dev/null 2>&1 || \
  (echo '👊  Installing chezmoi' && /opt/homebrew/bin/brew install chezmoi)

# Generate SSH
if [ ! -f ~/.ssh/id_rsa.pub ]; then
  ssh-keygen
  cd ~/.ssh
  cat id_rsa.pub | pbcopy
  echo "New SSH key copied to clipboard, add this now to Github."
  ssh-keyscan -t rsa github.com >> ~/.ssh/known_hosts
fi

# Chezmoi
echo ""
echo "Then initialise all dotfiles with:"
echo "chezmoi init --apply https://github.com/muntasirsyed/dotfiles.git"

echo "Done."