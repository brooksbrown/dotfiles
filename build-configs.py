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
  'pathogen' : {
    'source_type' : 'file',
    'source' : 'https://tpo.pe/pathogen.vim',
    'destination' : 'autoload/pathogen.vim',
  },
  'tagbar' : {
    'source_type' : 'git',
    'tag' : 'v2.6.1',
    'source' : 'git@github.com:majutsushi/tagbar.git',
    'destination' : 'bundle/tagbar'
  },
  'easymotion' : {
    'source_type' : 'git',
    'tag' : '2.0',
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
    'tag' : 'v0.6',
    'source' : 'git@github.com:bling/vim-airline.git',
    'destination' : 'bundle/airline'
  },
  'bookmarks' : {
    'source_type' : 'git',
    'tag' : '1.1.0',
    'source' : 'git@github.com:MattesGroeger/vim-bookmarks.git',
    'destination' : 'bundle/bookmarks'
  },
  'indent-guides' : {
    'source_type' : 'git',
    'tag' : '1.6',
    'source' : 'git@github.com:nathanaelkane/vim-indent-guides.git',
    'destination' : 'bundle/indent-guides'
  },
  'xoria256' : {
    'source_type' : 'file',
    'tag' : '1.5',
    'source' : 'http://www.vim.org/scripts/download_script.php?src_id=15762',
    'destination' : 'colors/xoria256.vim'
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
    os.system('sudo apt-get install tmux exuberant-ctags -y')

#remove old .vim directory and configs
if os.path.isdir(home + '/.vim'):
  print 'Removing ' + home + '/.vim'
  shutil.rmtree(home + '/.vim')

if os.path.isfile(home + '/.vimrc'):
  print 'Removing ' + home + '/.vimrc'
  os.remove(home + '/.vimrc')

#remove old tmux.conf
if os.path.isfile(home + '/.tmux.conf'):
  print 'Removing ' + home + '/.tmux.conf'
  os.remove(home + '/.tmux.conf')

#remove old gitconfig
if os.path.isfile(home + '/.gitconfig'):
  print 'Removing ' + home + '/.gitconfig'
  os.remove(home + '/.gitconfig')

#remove old gitconfig
if os.path.isfile(home + '/.bashrc'):
  print 'Removing ' + home + '/.bashrc'
  os.remove(home + '/.bashrc')

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


