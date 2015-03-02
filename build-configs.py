#!/usr/bin/env python

import os
import shutil
import distutils.core
import platform

home = os.path.expanduser('~')
this_dir = os.path.dirname(os.path.realpath(__file__))

#temp config for dev

vim_dir = home + '/.vim'

vim_dependencies = {
  'pathogen' : { 'source_type' : 'file',
    'source' : 'https://tpo.pe/pathogen.vim',
    'destination' : 'autoload/pathogen.vim',
  },
  'tagbar' : {
    'source_type' : 'git',
    'tag' : 'v2.6.1',
    'source' : 'git@github.com:majutsushi/tagbar.git',
    'destination' : 'bundle/tagbar'
  },
  'fugitive' : {
    'source_type' : 'git',
    'tag' : 'v2.2',
    'source' : 'git@github.com:tpope/vim-fugitive.git',
    'destination' : 'bundle/fugitive'
  },
  'gitgutter' : {
    'source_type' : 'git',
    'tag' : 'master',
    'source' : 'git@github.com:airblade/vim-gitgutter.git',
    'destination' : 'bundle/gitgutter'
  },
  'easymotion' : {
    'source_type' : 'git',
    'tag' : 'v2.1.0',
    'source' : 'git@github.com:Lokaltog/vim-easymotion.git',
    'destination' : 'bundle/easymotion'
  },
  'ctrlp' : {
    'source_type' : 'git',
    'tag' : '1.79',
    'source' : 'git@github.com:kien/ctrlp.vim.git',
    'destination' : 'bundle/ctrlp'
  },
  'vdebug' : {
    'source_type' : 'git',
    'tag' : 'v1.4.1',
    'source' : 'git@github.com:joonty/vdebug.git',
    'destination' : 'bundle/vdebug'
  },
  'airline' : {
    'source_type' : 'git',
    'tag' : 'v0.7',
    'source' : 'git@github.com:bling/vim-airline.git',
    'destination' : 'bundle/airline'
  },
  'syntastic' : {
    'source_type' : 'git',
    'tag' : '3.6.0',
    'source' : 'git@github.com:scrooloose/syntastic.git',
    'destination' : 'bundle/syntastic'
  },
  'bookmarks' : {
    'source_type' : 'git',
    'tag' : '1.3.0',
    'source' : 'git@github.com:MattesGroeger/vim-bookmarks.git',
    'destination' : 'bundle/bookmarks'
  },
  'indent-guides' : {
    'source_type' : 'git',
    'tag' : '1.6',
    'source' : 'git@github.com:nathanaelkane/vim-indent-guides.git',
    'destination' : 'bundle/indent-guides'
  },
  'tmuxline' : {
    'source_type' : 'git',
    'tag' : 'master',
    'source' : 'https://github.com/edkolev/tmuxline.vim.git',
    'destination' : 'bundle/tmuxline.vim'
  },
  'xoria256' : {
    'source_type' : 'file',
    'tag' : '1.5',
    'source' : 'http://www.vim.org/scripts/download_script.php?src_id=15762',
    'destination' : 'colors/xoria256.vim'
  },
  'vim-colors-solarized' : {
    'source_type' : 'git',
    'tag' : 'master',
    'source' : 'git://github.com/altercation/vim-colors-solarized.git',
    'destination' : 'bundle/vim-colors-solarized'
  },
} 

def get_vim_dependencies():
  for name, dep in vim_dependencies.iteritems():
    print 'vim dependency: ' + name + '\n\n'

    if dep['source_type'] == 'file':
      os.system('curl -LSso ' + vim_dir + '/' + dep['destination'] + ' ' + dep['source'])

    elif dep['source_type'] == 'git':
      os.system('git clone ' + dep['source'] + ' ' + vim_dir + '/' + dep['destination'])
      os.chdir(vim_dir + '/' + dep['destination'])
      os.system('git checkout ' + dep['tag'])
      os.chdir(this_dir)

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

#remove old gitconfig
remove_path(home + '/.bashrc')

#copying over vim config skeleton
os.mkdir(home + '/.vim')
os.mkdir(home + '/.vim/autoload')
os.mkdir(home + '/.vim/bundle')
os.mkdir(home + '/.vim/colors')

get_system_dependencies()
get_vim_dependencies()

shutil.copyfile(this_dir + '/tmux.conf', home + '/.tmux.conf')
shutil.copyfile(this_dir + '/vimrc', home + '/.vimrc')
shutil.copyfile(this_dir + '/gitconfig', home + '/.gitconfig')
shutil.copyfile(this_dir + '/bashrc', home + '/.bashrc')


