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

set mouse=a     " enable mouse

" Do not create backup files
set nobackup
set nowritebackup
set noswapfile

syntax on		" syntax highlightling
filetype on		" based on names

filetype indent on
filetype plugin indent on
set nowrap        " no line wrap
set tabstop=4     " todo ?
set shiftwidth=4  " todo ?
set expandtab     " todo ?
set smartindent   " todo ?
set autoindent    " todo ?

set showmatch "brackets

set numberwidth=4   "Set the line numbers to 4 space

set colorcolumn=80

set showcmd

set scrolloff=2

set title

set hlsearch
nohlsearch
set incsearch


" List completions
set wildmode=longest:list,full


let mapleader=","
let localleader="\\"
            

map <leader>s :source ~/.vim/vimrc

set hidden
set history=1000



inoremap jk <Esc>

" Convert word to uppercase
inoremap <C-U> <Esc>viwUea

nnoremap <silent> <leader>, :cprevious<CR>
nnoremap <silent> <leader>. :cnext<CR>


let g:airline_powerline_fonts = 1

" YCM settings {{{
let g:clang_library_path = "/usr/lib64/"
let g:clang_complete_copen = 0
let g:clang_hl_errors = 1
let g:clang_snippets = 1
let g:clang_snippets_engine = "ultisnips"
let g:clang_close_preview = 1
let g:clang_complete_macros = 1

let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_use_ultisnips_completer = 1
let g:ycm_key_list_select_completion=[]
let g:ycm_key_list_previous_completion=[]

let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"
" }}}


" nerdtree

let NERDTreeHijackNetrw=1


