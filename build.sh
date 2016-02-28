#!/bin/bash


if [[ $1 != '--min' ]]; then

  #OS PREP
  if [[ "`command -v lsb_release`" != '' ]]; then
    if [[ "`lsb_release -i | sed 's/Distributor\ ID\:\t//'`" == 'Ubuntu' ]] || 
      [[ "`lsb_release -i | sed 's/Distributor\ ID\:\t//'`" == 'LinuxMint' ]]; then
      #UBUNTU
      sudo apt-get update
      sudo apt-get install git curl vim tmux exuberant-ctags python-pip markdown xdotool -y
      sudo pip install powerline-status
    fi
  elif [[ "$(UNAME)" == "Darwin" ]]; then
    #MACOSX
    brew install python tmux ctags
  fi
fi

#Remove old dotfiles
rm -rf ~/.vim
rm ~/.vimrc
rm ~/.tmux.conf
rm ~/.gitconfig
rm ~/.bashrc
rm ~/.dotfiles-cheatsheet.txt

mkdir -p ~/.vim/autoload
mkdir ~/.vim/bundle
mkdir ~/.vim/colors

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

#Copy dotfiles over
cp tmux.conf ~/.tmux.conf
cp vimrc ~/.vimrc
cp gitconfig ~/.gitconfig
cp bashrc ~/.bashrc
cp bash_aliases ~/.bash_aliases
cp cheatsheet.txt ~/.dotfiles-cheatsheet.txt

if [[ "$(uname)" == "Darwin" ]]; then
  touch ~/.bash_profile
  echo "if [ -f ~/.bashrc ]; then . ~/.bashrc; fi" >> ~/.bash_profile
fi

#Install vim bundles
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
if [[ "$(uname)" != "Darwin" ]]; then 
  sed -i 's/colorscheme solarized/" colorscheme solarized/g' ~/.vimrc
fi

vim +PluginInstall +qall +silent

if [[ "$(uname)" != "Darwin" ]]; then
  sed -i 's/" colorscheme solarized/colorscheme solarized/g' ~/.vimrc
fi

echo 'Ensure the terminal emulator font is set!'
