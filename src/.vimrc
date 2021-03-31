" BEGIN Vundle config
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'sheerun/vim-polyglot'
call vundle#end()
filetype plugin indent on
" END   Vundle config

set re=0

set autowrite
set rnu
set number
set hlsearch
set ruler
set cmdheight=2
set ignorecase
set smartcase
set showmatch
set noerrorbells
set encoding=utf8

set expandtab
set smarttab
set tabstop=4
set shiftwidth=4
set ai
set si
set wrap

syntax enable

" delek desert peachpuff ron
color ron
