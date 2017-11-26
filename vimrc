""" Use pathogen to load further modules from plugins/
filetype off
runtime plugins/pathogen/autoload/pathogen.vim
let g:pathogen_disabled = []
"call add(g:pathogen_disabled, 'YouCompleteMe')
silent! call pathogen#infect('plugins/{}')
silent! call pathogen#helptags()

call plug#begin('~/.vim/plugged')

Plug 'https://github.com/jceb/vim-orgmode.git'

call plug#end()

let name = "Bastian Zeller"

colorscheme Tomorrow-Night-Bright

set number		" line numbering
set relativenumber	" relative numbering

syntax on		" syntax highlightling
filetype on		" based on names

filetype indent on
filetype plugin indent on
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


