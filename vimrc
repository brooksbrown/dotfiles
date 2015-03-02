runtime bundle/pathogen/autoload/pathogen.vim
call pathogen#infect()

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
