" https://raw.githubusercontent.com/rasendubi/dotfiles/master/.vimrc
" https://github.com/Valloric/YouCompleteMe#ubuntu-linux-x64
" https://github.com/JBakamovic/yavide
" https://vim.sourceforge.io/scripts/script.php?script_id=213
" https://www.reddit.com/r/vim/comments/5iz4cw/making_a_vim_setup_for_cc/
" test
"

""" Use pathogen to load further modules from plugins/
filetype off
runtime plugins/pathogen/autoload/pathogen.vim
let g:pathogen_disabled = []
call add(g:pathogen_disabled, 'ctrlp')
call add(g:pathogen_disabled, 'git-gutter')
call add(g:pathogen_disabled, 'nercommenter')
"call add(g:pathogen_disabled, 'speeddating')
call add(g:pathogen_disabled, 'supertab')
call add(g:pathogen_disabled, 'tagbar')
call add(g:pathogen_disabled, 'vim-fugitive')
silent! call pathogen#infect('plugins/{}')
silent! call pathogen#helptags()

" load org-mode
call plug#begin('~/.vim/plugged')
Plug 'https://github.com/jceb/vim-orgmode.git'
call plug#end()

let name = "Bastian Zeller"

" Do not create backup files
set nobackup
set nowritebackup
set noswapfile

set title           " set window title to filename
set mouse=a         " enable mouse

set hidden          " hide abandoned buffers
set history=10000   " big history

""" optics
colorscheme Tomorrow-Night-Bright

set number		    " line numbering
set numberwidth=4   " gutter = 4 columns
set relativenumber	" relative numbering
set colorcolumn=80  " highlight col80
set showcmd         " show command at bottom

""" syntax
syntax on		" syntax highlightling
filetype on		" based on names

""" indent
filetype indent on          " load indention ft based
filetype plugin indent on   " load ft based plugins
set nowrap          " no line wrapping
set tabstop=4       " tab = 4 columns
set shiftwidth=4    " 4 columns reindent
set expandtab       " expand tabs to spaces
set smartindent     " indention up to syntax of code
set autoindent      " automatically transfer indention to next line
set showmatch       " show matching brackets

set scrolloff=2     " minimal # of lines around the cursor


set hlsearch        " highlight search results 
nohlsearch          " why is this here??
set incsearch       " search while typing 


" List completions
set wildmode=longest:list,full  " todo ????


" keymappings
let mapleader=","       " leader ,
let localleader="\\"    " localleader \\

" reload vimrc
map <leader>s :source ~/.vim/vimrc 
" normal mode
"inoremap jk <Esc>  we just use ctrl+[

" Convert word to uppercase
inoremap <C-U> <Esc>viwUea

" <silent> wont echo cmd

nnoremap <silent> <leader>, :cprevious<CR>
nnoremap <silent> <leader>. :cnext<CR>

" fast c-style comments
:ab #b /****************************************
:ab #e *****************************************/

""" plugins settings

"let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='serene'

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


if getcwd() =~ "kernel"
    let g:ycm_global_ycm_extra_conf='~/ycm_extra_conf_kernel.py'
else
    let g:ycm_global_ycm_extra_conf='~/ycm_extra_conf.py'
endif

" }}}


" nerdtree
let NERDTreeHijackNetrw=1
map <C-n> :NERDTreeToggle<CR>


" org-mode

let g:org_agenda_files = [ '~/home/org/*.org', '~/home/org/info/*.org', '~/home/org/knowledge/*.org', '~/work/org/*.org']


