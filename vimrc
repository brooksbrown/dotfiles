set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

Plugin 'tpope/vim-fugitive'
Plugin 'majutsushi/tagbar'
Plugin 'airblade/vim-gitgutter'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'kien/ctrlp.vim'
Plugin 'joonty/vdebug'
Plugin 'bling/vim-airline'
Plugin 'scrooloose/syntastic'
Plugin 'MattesGroeger/vim-bookmarks'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'edkolev/tmuxline.vim'
Plugin 'xoria256.vim'
Plugin 'altercation/vim-colors-solarized.git'

call vundle#end()


syntax on
filetype plugin indent on
let mapleader=","
nmap <leader>t :TagbarToggle<CR>
nmap <leader>r :CtrlPMRU<CR>
nmap <leader>b :CtrlPBuffer<CR>
set hidden

set nowrap
set number
set showmatch
set ignorecase
set smartcase
set hlsearch
set incsearch

set nobackup
set noswapfile

set smarttab
set tabstop=2
set shiftwidth=2
set expandtab
set autoindent
set copyindent

set t_Co=256

set laststatus=2

set background=dark
let g:solarized_termcolors=256
colorscheme solarized

highlight clear SignColumn

let g:airline_powerline_fonts = 1
