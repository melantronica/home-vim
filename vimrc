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
"call add(g:pathogen_disabled, 'YouCompleteMe') 
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
set mouse=a         " enable mouse in all modes

"set virtualedit=all                     " move around freely

" {{{ cursor

""" fancy cursor-crosshair
augroup CursorLine
    au!
    au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    au VimEnter,WinEnter,BufWinEnter * setlocal cursorcolumn
    au WinLeave * setlocal nocursorline
    au WinLeave * setlocal nocursorcolumn
augroup END

let g:syntastic_check_on_open=1
let g:syntastic_check_on_wq=0


""" lines around the cursor
"set scrolloff=3        " min 3 lines above/below cursor while scrolling
" cursor centered
set scrolloff=999

" cursor is dash when in insert mode
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

" optional reset cursor on start:
augroup myCmds
au!
autocmd VimEnter * silent !echo -ne "\e[2 q"
augroup END


set hidden          " hide abandoned buffers
set history=10000   " big history

""" optics
colorscheme Tomorrow-Night-Bright

set number		    " line numbering
set numberwidth=4   " gutter = 4 columns
set relativenumber	" relative numbering
set showcmd         " show command at bottom

" highlight long lines
"set colorcolumn=80  " highlight col80 
highlight ColorColumn ctermbg=darkred
call matchadd('ColorColumn', '\%79v', 102)  

set foldmethod=indent
"set foldlevel=1

""" syntax
syntax on		" syntax highlightling
filetype on		" based on names

""" indent
set nocompatible
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

" :B ghetto bufferlist
command! -nargs=? -bang B if <q-args> != '' | exe 'buffer '.<q-args> | else | ls<bang> | let buffer_nn=input('Choose buffer: ') | if buffer_nn != '' | exe buffer_nn != 0 ? 'buffer '.buffer_nn : 'enew' | endif | endif

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
"let g:clang_snippets = 1l
"let g:clang_snippets_engine = "ultisnips"
let g:clang_close_preview = 1
"let g:clang_complete_macros = 1

let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_use_ultisnips_completer = 1
let g:ycm_key_list_select_completion=[]
let g:ycm_key_list_previous_completion=[]

let g:ycm_min_num_of_chars_for_completion = 3


let g:ycm_global_ycm_extra_conf='~/ycm_extra_conf.py'
"let g:ycm_global_ycm_extra_conf='~/ycm_extra_conf_kernel.py'

" }}}


" nerdtree
let NERDTreeHijackNetrw=1
map <C-n> :NERDTreeToggle<CR>


" org-mode

let g:org_agenda_files = [ '~/home/org/*.org', '~/home/org/info/*.org', '~/home/org/knowledge/*.org', '~/work/org/*.org']

" markdown

let g:markdown_fold_style = 'nested' " or 'stacked'                  
"let g:markdown_fold_override_foldtext = 0
"set nofoldenable                          
set foldlevel=99

" highlighte long lines
highlight ColorColumn ctermbg=darkred
    

" diff local buffer
function! s:DiffWithSaved()
  let filetype=&ft
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call s:DiffWithSaved()

"  '!diff  --color=always % -'


"" whitespaces
" http://vim.wikia.com/wiki/Highlight_unwanted_spaces
let g:whitespacemode = 'nospace'
function! TntclToggleWhitespace()
    if  g:whitespacemode == 'nospace' 
        let g:whitespacemode = 'noeol'
        exec "set listchars=eol:$,tab:\uBB\uBB,trail:\uB7,nbsp:~,precedes:\uB7,extends:\uB7"
        echo "showing no spaces"
    elseif  g:whitespacemode == 'noeol' 
        let g:whitespacemode = 'all'
        exec "set listchars=tab:\uBB\uBB,trail:\uB7,nbsp:~,precedes:\uB7,extends:\uB7"
        echo "no spaces no tabs"
    elseif g:whitespacemode == 'all'  
        let g:whitespacemode = 'nospace'
        exec "set listchars=eol:$,tab:\uBB\uBB,trail:\uB7,nbsp:~,precedes:\uB7,extends:\uB7,space:\uB7"
        echo "showing all"
   endif     
endfunction

exec "set listchars=eol:$,tab:\uBB\uBB,trail:\uB7,nbsp:~,precedes:\uB7,extends:\uB7"
map <leader>W :set list!<CR>
map <leader>w :call TntclToggleWhitespace()<CR>


set list

