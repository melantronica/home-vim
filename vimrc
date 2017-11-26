let name = "Bastian Zeller"

colorscheme Tomorrow-Night-Bright

set number		" line numbering
set relativenumber	" relative numbering

syntax on		" syntax highlightling
filetype on		" based on names

filetype indent on
set nowrap
set tabstop=4
set shiftwidth=4
set expandtab
set smartindent
set autoindent


set numberwidth=4   "Set the line numbers to 4 space

set colorcolumn=80

set hlsearch

set showmatch


let mapleader=","

map <leader>s :source ~/.vimrc

set hidden
set history=1000

execute pathogen#infect()

