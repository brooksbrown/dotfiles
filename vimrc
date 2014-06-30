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

colorscheme xoria256

let indent_guides_auto_colors = 0
hi IndentGuidesOdd  ctermbg=black
hi IndentGuidesEven ctermbg=grey
let indent_guides_guide_size = 1
