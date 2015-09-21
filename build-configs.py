#!/usr/bin/env python

import os
import shutil
import distutils.core
import platform

home = os.path.expanduser('~')
this_dir = os.path.dirname(os.path.realpath(__file__))

vim_dir = home + '/.vim'


def get_system_dependencies():
  dist = platform.dist()
  if dist[0] == 'Ubuntu':
    os.system('sudo apt-get install vim tmux exuberant-ctags -y')

def remove_path(path):
  if os.path.isdir(path):
    print 'Removing ' + path
    shutil.rmtree(path)
  elif os.path.isfile(path):
    print 'Removing ' + path 
    os.remove(path)

#remove old .vim directory and configs
remove_path(home + '/.vim')
remove_path(home + '/.vimrc')

#remove old tmux.conf
remove_path(home + '/.tmux.conf')

#remove old gitconfig
remove_path(home + '/.gitconfig')

#remove old bash config
remove_path(home + '/.bashrc')

#copying over vim config skeleton
os.mkdir(home + '/.vim')
os.mkdir(home + '/.vim/autoload')
os.mkdir(home + '/.vim/bundle')
os.mkdir(home + '/.vim/colors')

get_system_dependencies()

os.system('git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim')

shutil.copyfile(this_dir + '/tmux.conf', home + '/.tmux.conf')
shutil.copyfile(this_dir + '/vimrc', home + '/.vimrc')
shutil.copyfile(this_dir + '/gitconfig', home + '/.gitconfig')
shutil.copyfile(this_dir + '/bashrc', home + '/.bashrc')

os.system('vim -u NONE +PluginInstall +qall +Silent')
