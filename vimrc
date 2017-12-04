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
"call add(g:pathogen_disabled, 'airline-themes')            " airline themes
"call add(g:pathogen_disabled, 'awesome-vim-colorschemes')  " some nice colors
"call add(g:pathogen_disabled, 'conque-gdb')                " gdb integration 
"call add(g:pathogen_disabled, 'ctrlp')                     " fuzzy finder
"call add(g:pathogen_disabled, 'git-gutter')                " see git status in the gutter
"call add(g:pathogen_disabled, 'nerdcommenter')
"call add(g:pathogen_disabled, 'nerdtree')
"call add(g:pathogen_disabled, 'OmniCppComplete')
"call add(g:pathogen_disabled, 'pathogen')
"call add(g:pathogen_disabled, 'riv')                       " rst note taking
"call add(g:pathogen_disabled, 'subertab')                   " magic tab key TODO
"call add(g:pathogen_disabled, 'syntastic')                  " not sure if I want that
"call add(g:pathogen_disabled, 'tagbar')
"call add(g:pathogen_disabled, 'vim-airline')
"call add(g:pathogen_disabled, 'vim-fugitive')
"call add(g:pathogen_disabled, 'vim-gutentags')
"call add(g:pathogen_disabled, 'vim-markdown')
"call add(g:pathogen_disabled, 'vim-markdown-folding')
"call add(g:pathogen_disabled, 'vim-surround')
call add(g:pathogen_disabled, 'YouCompleteMe')

silent! call pathogen#infect('plugins/{}')
silent! call pathogen#helptags()


"source ~/.vim/plugins/gtags/gtags.vim
"source ~/.vim/plugins/gtags/gtags-cscope.vim

"" # }}}

"" # general {{{
let name = "Bastian Zeller"

"" automatically set current path to buffer path
" autocmd BufEnter * silent! lcd %:p:h

"" color map:
"" http://www.calmar.ws/vim/256-xterm-24bit-rgb-color-chart.html

let mapleader=","       " leader , (comma)
let localleader="\\"    " localleader \\ (backslash)

"" copy paste from x clipboard
set clipboard=unnamedplus

"" Do not create backup files
set nobackup
set nowritebackup
set noswapfile

"set title               " set window title to filename
set mouse=a             " enable mouse in all modes
"set virtualedit=all    " move around freely

set hidden              " hide abandoned buffers
set history=10000       " big history

"" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

"" :B ghetto bufferlist
command! -nargs=? -bang B if <q-args> != '' | exe 'buffer '.<q-args> | else | ls<bang> | let buffer_nn=input('Choose buffer: ') | if buffer_nn != '' | exe buffer_nn != 0 ? 'buffer '.buffer_nn : 'enew' | endif | endif

" List completions
set wildmode=longest:list,full  " completition style

au CursorHold * checktime

"" global macro in slop p
map <f8> qp
map <f9> @p

" # }}}

"" # syntax, highlight {{{
"colorscheme Tomorrow-Night-Bright
colorscheme tentacle

set number		    " line numbering
set numberwidth=4   " gutter = 4 columns
set relativenumber	" relative numbering
set showcmd         " show command at bottom

"" toggle relative numbers
nnoremap <silent> <leader>l :set rnu!<CR>

" highlight long lines
"set colorcolumn=80  " highlight col80 
highlight ColorColumn ctermbg=darkred
call matchadd('ColorColumn', '\%79v', 102)  

"" syntax
set nocompatible
syntax on		    " syntax highlightling
filetype on		    " based on names
filetype indent on  " load indention ft based
filetype plugin indent on   " load ft based plugins

"" indent
set nowrap          " no line wrapping
set tabstop=4       " tab = 4 columns
set shiftwidth=4    " 4 columns reindent
set expandtab       " expand tabs to spaces
set smartindent     " indention up to syntax of code
set autoindent      " automatically transfer indention to next line
set showmatch       " show matching brackets

set hlsearch        " highlight search results 
nohlsearch          " why is this here??
set incsearch       " search while typing 
"" # }}}

"" # compeltion {{{

"" close preview after completion done
autocmd CompleteDone * pclose

function! UpdateTags()
  execute ":!ctags -R --languages=C++ --c++-kinds=+p --fields=+iaS --extra=+q ./"
  echohl StatusLine | echo "C/C++ tag updated" | echohl None
endfunction


"" # }}}

"" # cursor {{{

""" fancy cursor-crosshair
"augroup CursorLine
"    au!
"    au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
"    au VimEnter,WinEnter,BufWinEnter * setlocal cursorcolumn
"    au WinLeave * setlocal nocursorline
"    au WinLeave * setlocal nocursorcolumn
"augroup END

set cursorline
set cursorcolumn

let g:syntastic_check_on_open=1     "
let g:syntastic_check_on_wq=0       "

""" lines around the cursor
"set scrolloff=2    " minimal # of lines around the cursor
set scrolloff=3     " mininmal # of lines around the cursor
"set scrolloff=999  " cursor centered


" cursor is dash when in insert mode
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"
" optional reset cursor on start:
augroup myCmds
au!
autocmd VimEnter * silent !echo -ne "\e[2 q"
augroup END
"" # }}}

"" # folding {{{
"" make folded blocks more readable
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

set nofoldenable        " we start without folding
set foldlevel=1         " if enabled we want to have foldlevel 1 expanded
set foldmethod=marker   " default mode is marker, so {{{ }}} gives us folding

"" toggle through different foldmethods
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
"" # }}}

"" # whitespaces {{{
set list    " show listchars by default
set listchars=eol:$,tab:\ \ ,trail:·,nbsp:~,precedes:·,extends:·
" http://vim.wikia.com/wiki/Highlight_unwanted_spaces

"" function to switch between different listchars
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

"" " keybindings
"" on/off
map <leader>W :set list!<CR>                        
"" toggle visible listchars
map <leader>w :call TntclToggleWhitespace()<CR>
"" # }}}

"" # diff buffer {{{
"" diff local buffer
function! s:DiffWithSaved()
  let filetype=&ft
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call s:DiffWithSaved()

"" another way of diffing local changes
"  '!diff  --color=always % -'
"" # }}}

"" # keybindings {{{
"" https://blog.codepen.io/2014/02/21/vim-key-bindings/
"" https://hea-www.harvard.edu/~fine/Tech/vi.html
"" <silent> wont echo cmd

"" leader keys
"" reload vimrc
map <leader>s :source ~/.vim/vimrc 


"" edit file with current path filled out
map <leader>e :e <C-R>=expand("%:p:h") . "/" <CR>


"" normal mode
"inoremap jk <Esc>  we just use ctrl+[

" Convert word to uppercase
inoremap <C-U> <Esc>viwUea

nnoremap <silent> <leader>, :cprevious<CR>
nnoremap <silent> <leader>. :cnext<CR>

"" shift+arrow selection
nmap <S-Up> v<Up>
nmap <S-Down> v<Down>
nmap <S-Left> v<Left>
nmap <S-Right> v<Right>
vmap <S-Up> <Up>
vmap <S-Down> <Down>
vmap <S-Left> <Left>
vmap <S-Right> <Right>
imap <S-Up> <Esc>v<Up>
imap <S-Down> <Esc>v<Down>
imap <S-Left> <Esc>v<Left>
imap <S-Right> <Esc>v<Right>
"" shift+home selection
imap <S-Home> <C-o>v<Home>
imap <S-End> <C-o>v<End>
nmap <S-Home> v<Home>
nmap <S-End> v<End>

"" ctrl-cxv
"vmap <C-c> y<Esc>
"vmap <C-x> d<Esc>
"map  <C-v> p
"imap <C-v> <C-o>p
"imap <C-z> <C-o>u
"" ctrl+hjkl
imap <C-h> <C-o>h
imap <C-j> <C-o>j
imap <C-k> <C-o>k
imap <C-l> <C-o>l

"" we want to wrap around lines with movement and backspace
set whichwrap+=h,l,<,>,[,]
set backspace=indent,eol,start
"" # }}}

"" # abbrev {{{
" fast c-style comments
:ab #b /****************************************
:ab #e *****************************************/
"" }}}

"" # plugin settings {{{

"" ## conque-gdb {{{
let g:ConqueTerm_StartMessages = 0
let g:ConqueTerm_CloseOnEnd = 1
let g:ConqueTerm_Interrupt = '<C-g><C-c>'
let g:ConqueTerm_ReadUnfocused = 1
let g:ConqueGdb_Leader = '\\'
"" ##}}}

"" ## airline {{{
"let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='serene'
"" ## }}}

let g:gitgutter_enabled = 0

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0


"" ## YCM settings {{{

"" ### completion triggers {{{
"" keybindings
let g:ycm_key_invoke_completion = '<C-Space>'
let g:ycm_key_list_select_completion=['<TAB>', '<Down>']
let g:ycm_key_list_previous_completion=['<S-TAB>', '<Up>']

"" disable in-buffer auto-completition popup
let g:ycm_min_num_of_chars_for_completion = 99  " disable identifier completer
"let g:ycm_auto_trigger = 0                      " disable identifier+semantic completer

let g:ycm_complete_in_comments = 1              " comment inline completion
let g:ycm_complete_in_strings = 1               " string completion

"" ### }}}

"" ### keybindings {{{
nnoremap <leader>y :YcmCompleter GoTo<CR>
nnoremap <leader>Y :YcmCompleter GoTo
"" ### }}}

"" ### window behaviour {{{

"" automatically close preview after selction
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1

"" open gotos in a vertical split
""[ 'same-buffer', 'horizontal-split', 'vertical-split', 'new-tab', 'new-or-existing-tab' ] 
let g:ycm_goto_buffer_command = 'same-buffer'
"" ### }}}

"" ### identifier sources {{{
let g:ycm_collect_identifiers_from_tags_files = 1   " we want tags files to be used
let g:ycm_seed_identifiers_with_syntax = 0          " use vims syntax file to get language identifiers
"" ### }}}

"" ### ycm_extra_conf {{{
let g:ycm_confirm_extra_conf = 0                    " automatically load extra conf when found recursively
let g:ycm_global_ycm_extra_conf='~/.vim/templates/ycm_extra_conf.py.kernel'   " otherwise load this
"let g:ycm_global_ycm_extra_conf='~/ycm_extra_conf.py.kernel'
"let g:ycm_global_ycm_extra_conf='~/ycm_extra_conf.py.android'

"" white- and blacklist for conf files (! is blocklist)
"let g:ycm_extra_conf_globlist = ['~/dev/*','!~/*']
"" ### }}}
"" ## }}}

"" ## nerdtree {{{
let NERDTreeHijackNetrw=1
map <C-n> :NERDTreeToggle<CR>
"" ## }}}

"" ## markdown {{{
let g:markdown_fold_style = 'nested' " or 'stacked'
"let g:markdown_fold_override_foldtext = 0
"" }}}

"" ## ctrlp {{{
"nunmap <C-p>
nmap <C-p> :CtrlPBuffer 
"" ## }}}

"" ## gutentags {{{
let g:gutentags_define_advanced_commands=1 
let g:gutentags_resolve_symlinks=1
let g:gutentags_enabled=0
command! GutentagsGetEnabled :echo g:gutentags_enabled
"" ## }}}


"" }}}


