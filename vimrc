"" vimrc
"" Bastian Zeller

"" # some links {{{
"" https://raw.githubusercontent.com/rasendubi/dotfiles/master/.vimrc
"" https://github.com/Valloric/YouCompleteMe#ubuntu-linux-x64
"" https://github.com/JBakamovic/yavide
"" https://vim.sourceforge.io/scripts/script.php?script_id=213
"" https://www.reddit.com/r/vim/comments/5iz4cw/making_a_vim_setup_for_cc/
"" test

"" # }}}

"" # pathogen {{{
"" Use pathogen to load further modules from plugins/
filetype off
runtime plugins/pathogen/autoload/pathogen.vim
let g:pathogen_disabled = []
"" disabled plugins
"call add(g:pathogen_disabled, 'airline-themes')
"call add(g:pathogen_disabled, 'awesome-vim-colorschemes')
call add(g:pathogen_disabled, 'ctrlp')
call add(g:pathogen_disabled, 'easytags')
call add(g:pathogen_disabled, 'git-gutter')
call add(g:pathogen_disabled, 'nerdcommenter')
call add(g:pathogen_disabled, 'nerdtree')
"call add(g:pathogen_disabled, 'pathogen')
call add(g:pathogen_disabled, 'speeddating')
call add(g:pathogen_disabled, 'subertab')
call add(g:pathogen_disabled, 'syntastic')
call add(g:pathogen_disabled, 'tagbar')
"call add(g:pathogen_disabled, 'vim-airline')
call add(g:pathogen_disabled, 'vim-fugitive')
"call add(g:pathogen_disabled, 'vim-markdown')
"call add(g:pathogen_disabled, 'vim-markdown-folding')
call add(g:pathogen_disabled, 'vim-misc')
call add(g:pathogen_disabled, 'vim-surround')
"call add(g:pathogen_disabled, 'YouCompleteMe')


silent! call pathogen#infect('plugins/{}')
silent! call pathogen#helptags()
"" # }}}

"" # general {{{
let name = "Bastian Zeller"

"" automatically set current path to buffer path
" autocmd BufEnter * silent! lcd %:p:h

"" color map:
"" http://www.calmar.ws/vim/256-xterm-24bit-rgb-color-chart.html

"" copy paste from x clipboard
set clipboard=unnamedplus

"" Do not create backup files
set nobackup
set nowritebackup
set noswapfile

set title               " set window title to filename
set mouse=a             " enable mouse in all modes
"set virtualedit=all    " move around freely

set hidden              " hide abandoned buffers
set history=10000       " big history

"" :B ghetto bufferlist
command! -nargs=? -bang B if <q-args> != '' | exe 'buffer '.<q-args> | else | ls<bang> | let buffer_nn=input('Choose buffer: ') | if buffer_nn != '' | exe buffer_nn != 0 ? 'buffer '.buffer_nn : 'enew' | endif | endif


" List completions
set wildmode=longest:list,full  " completition style

"" # }}}

"" # cursor {{{

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
set scrolloff=3        " min 3 lines above/below cursor while scrolling
" cursor centered
"set scrolloff=999

" cursor is dash when in insert mode
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

" optional reset cursor on start:
augroup myCmds
au!
autocmd VimEnter * silent !echo -ne "\e[2 q"
augroup END


"" # }}}

"" # colors {{{
"colorscheme Tomorrow-Night-Bright
colorscheme tentacle

set number		    " line numbering
set numberwidth=4   " gutter = 4 columns
set relativenumber	" relative numbering
set showcmd         " show command at bottom

" highlight long lines
"set colorcolumn=80  " highlight col80 
highlight ColorColumn ctermbg=darkred
call matchadd('ColorColumn', '\%79v', 102)  

"" syntax
syntax on		" syntax highlightling
filetype on		" based on names


"" indent
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


"" # }}}

"" # keybindings {{{
"" https://blog.codepen.io/2014/02/21/vim-key-bindings/
"" https://hea-www.harvard.edu/~fine/Tech/vi.html

" keymappings
let mapleader=","       " leader ,
let localleader="\\"    " localleader \\

" reload vimrc
map <leader>s :source ~/.vim/vimrc 
" leader-e gives us and edit command with the current path

map <leader>e :e <C-R>=expand("%:p:h") . "/" <CR>


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


"" # }}}

"" # plugin settings {{{

"" ## airline {{{
"let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='serene'
"" ## }}}

"" ## YCM settings {{{
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

let g:ycm_min_num_of_chars_for_completion = 99 

let g:ycm_global_ycm_extra_conf='~/ycm_extra_conf.py'
"let g:ycm_global_ycm_extra_conf='~/ycm_extra_conf_kernel.py'
let g:ycm_auto_trigger = 0
" ## }}}

"" ## nerdtree {{{
let NERDTreeHijackNetrw=1
map <C-n> :NERDTreeToggle<CR>
"" ## }}}

"" }}}

"" # folding {{{


function! FoldText()
    let line = getline(v:foldstart)

    let nucolwidth = &fdc + &number * &numberwidth
    let windowwidth = winwidth(0) - nucolwidth - 3
    let foldedlinecount = v:foldend - v:foldstart

    " expand tabs into spaces
    let onetab = strpart('          ', 0, &tabstop)
    let line = substitute(line, '\t', onetab, 'g')

    let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
    let fillcharcount = windowwidth - len(line) - len(foldedlinecount) - 9 
    return line . '   ' . repeat("-",fillcharcount) . ' [' . foldedlinecount . '] +++  '
endfunction 
set foldtext=FoldText()


let g:markdown_fold_style = 'nested' " or 'stacked'                  
"let g:markdown_fold_override_foldtext = 0
set nofoldenable                          
set foldlevel=1

noremap <Leader>zf :call <SID>ToggleFold()<CR>
function! s:ToggleFold()
    if &foldmethod == 'marker'
        let &l:foldmethod = 'syntax'
    elseif &foldmethod == 'syntax'
        let &l:foldmethod = 'indent'
    else
        let &l:foldmethod = 'marker'
    endif
    echo 'foldmethod is now ' . &l:foldmethod
endfunction
set foldmethod=marker

"" # }}}

"" # diff buffer {{{
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
"" # }}}

"" # whitespaces {{{
set list    " show listchars
" http://vim.wikia.com/wiki/Highlight_unwanted_spaces
let g:whitespacemode = 'nospacenotab'
function! TntclToggleWhitespace()
    if  g:whitespacemode == 'nospacenotab' 
        let g:whitespacemode = 'nospace'
        set listchars=eol:$,tab:\ \ ,trail:·,nbsp:~,precedes:·,extends:·
        echo "showing no spaces no tabs"
    elseif  g:whitespacemode == 'nospace' 
        let g:whitespacemode = 'noeol'
        set listchars=eol:$,tab:>\ ,trail:·,nbsp:~,precedes:·,extends:·
        echo "showing no spaces"
    elseif  g:whitespacemode == 'noeol' 
        let g:whitespacemode = 'all'
        set listchars=tab:>\ ,trail:·,nbsp:~,precedes:·,extends:·
        echo "no spaces no tabs"
    elseif g:whitespacemode == 'all'  
        let g:whitespacemode = 'nospacenotab'
        set listchars=eol:$,tab:>\ ,trail:·,nbsp:~,precedes:·,extends:·,space:·
        echo "showing all"
   endif     

endfunction
"" default setting
exec "set listchars=eol:$,tab:\uBB\uBB,trail:\uB7,nbsp:~,precedes:\uB7,extends:\uB7"
" on/off
map <leader>W :set list!<CR>
" toggle visible listchars
map <leader>w :call TntclToggleWhitespace()<CR>
"" # }}}


