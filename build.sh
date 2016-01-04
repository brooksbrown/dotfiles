#!/bin/bash


is_ubuntu(){
  if [[ "`command -v lsb_release`" != '' ]]; then
    if [[ "`lsb_release -i | sed 's/Distributor\ ID\:\t//'`" == 'Ubuntu' ]] || 
      [[ "`lsb_release -i | sed 's/Distributor\ ID\:\t//'`" == 'LinuxMint' ]]; then
      return $TRUE;
    fi
  fi
  return $FALSE
}

if [[ is_ubuntu ]]; then
  sudo apt-get update
  sudo apt-get install git curl vim tmux exuberant-ctags python-pip -y
  sudo pip install powerline-status
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

#Fonts
if [[ is_ubuntu ]]; then
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
cp cheatsheet.txt ~/.dotfiles-cheatsheet.txt

#Install vim bundles
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
sed -i 's/colorscheme solarized/" colorscheme solarized/g' ~/.vimrc
vim +PluginInstall +qall +silent
sed -i 's/" colorscheme solarized/colorscheme solarized/g' ~/.vimrc

echo 'Ensure the terminal emulator font is set!'
