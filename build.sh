#!/bin/bash

function is_mac {
  if [[ "$(command -v UNAME 2>/dev/null)" ]]; then
    if [[ "$(UNAME)" == "Darwin" ]]; then
      return 0;
    fi
  fi
  return 1;
}

function is_ubuntu {
  if [[ "`command -v lsb_release`" != '' ]]; then
    if [[ "`lsb_release -i | sed 's/Distributor\ ID\:\t//'`" == 'Ubuntu' ]] ||
      [[ "`lsb_release -i | sed 's/Distributor\ ID\:\t//'`" == 'LinuxMint' ]]; then
      return 0;
    fi
  fi
  return 1;
}

#os prep
if [[ $1 != '--min' ]]; then
  if is_ubuntu; then
    #UBUNTU
    sudo apt-get update
    sudo apt-get install git curl neovim tmux exuberant-ctags python-pip markdown xdotool -y
    sudo pip install powerline-status
  elif is_mac; then
    #MACOSX
    brew install python tmux ctags neovim
  fi
fi

#git
if [ -f ~/.gitconfig ]; then rm ~/.gitconfig; fi
cp gitconfig ~/.gitconfig

#bash
if [ -f ~/.bashrc ]; then rm ~/.bashrc; fi
cp bashrc ~/.bashrc

if [ -f ~/.bash_aliases ]; then rm ~/.bash_aliases; fi
cp bash_aliases ~/.bash_aliases

if [ -f ~/.dotfiles-cheatsheet.txt ]; then rm ~/.dotfiles-cheatsheet.txt; fi
cp cheatsheet.txt ~/.dotfiles-cheatsheet.txt

#neovim setup
if [ -f ~/.config/nvim ]; then rm -rf ~/.config/nvim; fi
cp -r nvim ~/.config/nvim
nvim +PlugInstall +qall

#tmux setup
if [ -f ~/.tmux.conf ]; then rm ~/.tmux.conf; fi
if [ -d ~/.tmux ]; then rm -rf ~/.tmux; fi
cp tmux.conf ~/.tmux.conf

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
~/.tmux/plugins/tpm/bin/update_plugins all


#terminal font setup
if [[ $1 != '--min' ]]; then
  #Fonts
  if [[ -d "~/.fonts/truetype/Anonymice Powerline" ]]; then
    rm -rf ~/.fonts/truetype/Anonymice\ Powerline
  fi

  mkdir -p ~/.fonts/truetype/Anonymice\ Powerline
  curl https://raw.githubusercontent.com/powerline/fonts/master/AnonymousPro/Anonymice%20Powerline.ttf > ~/.fonts/truetype/Anonymice\ Powerline/Anonymice\ Powerline.ttf
  curl https://raw.githubusercontent.com/powerline/fonts/master/AnonymousPro/Anonymice%20Powerline%20Bold.ttf > ~/.fonts/truetype/Anonymice\ Powerline/Anonymice\ Powerline\ Bold.ttf
  curl https://raw.githubusercontent.com/powerline/fonts/master/AnonymousPro/Anonymice%20Powerline%20Bold%20Italic.ttf > ~/.fonts/truetype/Anonymice\ Powerline/Anonymice\ Powerline\ Bold\ Italic.ttf
  curl https://raw.githubusercontent.com/powerline/fonts/master/AnonymousPro/Anonymice%20Powerline%20Italic.ttf > ~/.fonts/truetype/Anonymice\ Powerline/Anonymice\ Powerline\ Italic.ttf

  fc-cache -fv
fi

if is_mac; then
  touch ~/.bash_profile
  echo "if [ -f ~/.bashrc ]; then . ~/.bashrc; fi" >> ~/.bash_profile
fi

echo 'Ensure the terminal emulator font is set!'


