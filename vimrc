"" title:  vimrc
"" author: bastian zeller
""
"" for documentation visit this file
"" - [](vim.md)
""

"" # pathogen {{{1
if v:version < 800
    "" vim < 800 doen't have package management. we fallback to pathogen here
    "" plugins are stored in packs/{}/start/ or packs/{}/opt/
    "" opt packages sholdn't be loaded
    filetype off
    runtime pack/backports/opt/pathogen/autoload/pathogen.vim
    silent! call pathogen#infect('pack/{}/start/{}')
    silent! call pathogen#helptags()
endif


"" # general {{{1
let name = "Bastian Zeller"

set nocompatible            " turn off vi compatibility
set ttyfast                 " faster redeaw
set showcmd                 " show command

"" path for finding files, etc
set path=**,$HOME/home/**,/usr/include
",include,inc,
"    \ ..,../include,../inc,
"    \ ...,.../include,.../inc,
"    \ ...,.../include,.../inc,
"    \ /usr/include


filetype on		            " based on names
filetype indent on          " load indention ft based
filetype plugin indent on   " load ft based plugins

set encoding=utf-8          " fix encoding
set ff=unix                 " set file format
set shell=/bin/bash         " shell command

let readline_has_bash=1     " bash support for readline
let g:is_bash=1             " force bash

"" color map:
"" http://www.calmar.ws/vim/256-xterm-24bit-rgb-color-chart.html

"" leader
let mapleader=","
let g:mapleader=","
let localleader="\\"

"" options for physical printing
set printoptions=paper:a4
set printoptions=number:y " put line numbers on hardcopy

"" copy paste from x clipboard
"set clipboard=unnamedplus

set mouse=a|b           " enable mouse in all modes
"set virtualedit=all    " move around freely

set hidden              " hide abandoned buffers

"" check if the file was changed on disk
au CursorHold * checktime

"" :B ghetto bufferlist
command! -nargs=? -bang B if <q-args> != '' | exe 'buffer '.<q-args> | else | ls<bang> | let buffer_nn=input('Choose buffer: ') | if buffer_nn != '' | exe buffer_nn != 0 ? 'buffer '.buffer_nn : 'enew' | endif | endif

"" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap W!! w !sudo tee > /dev/null %

"" List completions
set wildmenu
set wildignore=.svn,CVS,.git,.hg,*.o,*.a,*.mo,*.la,*.so,*.obj,*.swp,*.xpm,*.exe,*.rar
"set wildmode=longest:list,full  " completition style
set wildmode=longest:full,full  " completition style

"" disable sounds
set noerrorbells
set visualbell





"" # backup, history, swap, viminfo, undo {{{1
set history=10000       " big history

" Tell vim to remember certain things when we exit
" "  '10  :  marks will be remembered for up to 10 previously edited files
" "  "100 :  will save up to 100 lines for each register
" "  :20  :  up to 20 lines of command-line history will be remembered
" "  %    :  saves and restores the buffer list
" "  n... :  where to save the viminfo files
"set viminfo='20,\"10000 " read/write a .viminfo file  """
set viminfo='500,\"3000,:50,%,n~/.vim/tmp/viminfo

"" Do not create backup files
set nobackup
set nowritebackup
set noswapfile

set undolevels=500          " 500 undos
set undoreload=10000        " number of lines
set undodir=~/vim/tmp/undo




"" # syntax, highlight {{{1
"https://jonasjacek.github.io/colors/

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
highlight ColorColumn ctermbg=127
call matchadd('ColorColumn', '\%79v', 127)  

"" syntax
syntax on		            " syntax highlightling

"" indent
set nowrap          " no line wrapping
set tabstop=4       " tab = 4 columnsi
set softtabstop=4
set shiftwidth=4    " 4 columns reindent
set expandtab       " expand tabs to spaces
set smarttab
set smartindent     " indention up to syntax of code
set autoindent      " automatically transfer indention to next line

""" don't lose visual selection after doing indents
vnoremap > >gv
vnoremap < <gv

set showmatch       " show matching brackets
set matchpairs+=<:> " add < >
set matchtime=1     " faster response

"" we want to wrap around lines with movement and backspace
set whichwrap+=h,l,<,>,[,]
set backspace=indent,eol,start

set hlsearch        " highlight search results 
nohlsearch          " why is this here??
set incsearch       " search while typing
set ignorecase      " 
set smartcase       " 

augroup vimrc_todo
    au!
    au Syntax * syn match MyTodo /\v<(todo|Todo|ToDo|TODO|FIXME|NOTE|OPTIMIZE|XXX)/
          \ containedin=ALL
augroup END
hi def link MyTodo Todo
hi def link MyTodo TodoRegion


"" disable highliting temporary (afterddiwpp search)
" keymapping:<F2> _clear search highliting
nnoremap <silent> <F2> :noh<CR>



"" # completion {{{1

set omnifunc=syntaxcomplete#Complete

"" close preview after completion done
autocmd CompleteDone * pclose

function! UpdateTags()
    execute ":!ctags -R --languages=C++ --c++-kinds=+p --fields=+iaS --extra=+q ./"
    echohl StatusLine | echo "C/C++ tag updated" | echohl None
endfunction

fu! My_cscope(func)
  let tmp1=&grepprg
  let tmp2=&grepformat
  set grepformat=%f\ %*[a-zA-Z_0-9]\ %l\ %m
  set grepprg=cscope\ -R\ -L\ -3
  exe "grep ".a:func
  exe "set grepprg=".escape(tmp1,' ')
  exe "set grepformat=".escape(tmp2, ' ')
endf
command! -nargs=* CScope :silent call My_cscope("<args>")



"" # grep {{{1

" This rewires n and N to do the blink for the next match
nnoremap <silent> n   n:call HLNext(0.1)<cr>
nnoremap <silent> N   N:call HLNext(0.1)<cr>

" highlight the match in red
function! HLNext (blinktime)
    highlight WhiteOnRed ctermfg=white ctermbg=red
    let [bufnum, lnum, col, off] = getpos('.')
    let matchlen = strlen(matchstr(strpart(getline('.'),col-1),@/))
    let target_pat = '\c\%#\%('.@/.'\)'
    let ring = matchadd('WhiteOnRed', target_pat, 101)
    redraw
    
    exec 'sleep ' . float2nr(a:blinktime * 1000) . 'm'
    call matchdelete(ring)
    redraw
endfunction


function! My_GrepTodo(func)
  let tmp1=&grepprg
  let tmp2=&grepformat
"  set grepformat=%f\ %*[a-zA-Z_0-9]\ %l\ %m
  set grepprg=/home/bastii/tmp/todo-agenda.sh
  exe "grep! ".a:func
  let &grepprg=tmp1
  let &grepformat=tmp2
  copen
endfunction
command! -nargs=* TodoGrep :silent call My_GrepTodo("<args>")


function! My_GrepFold(dir)
    setlocal foldlevel=0
    setlocal foldmethod=expr
    setlocal foldexpr=matchstr(getline(v:lnum),'^[^\|]\\+')==#matchstr(getline(v:lnum+1),'^[^\|]\\+')?1:'<1'
    setlocal foldtext=matchstr(getline(v:foldstart),'^[^\|]\\+').'\ ['.(v:foldend-v:foldstart+1).'\ lines]'
    if a:dir
        setlocal foldexpr=matchstr(substitute(getline(v:lnum),'\|.*','',''),'^.*/')==#matchstr(substitute(getline(v:lnum+1),'\|.*','',''),'^.*/')?1:'<1'
        setlocal foldtext=matchstr(substitute(getline(v:foldstart),'\|.*','',''),'^.*/').'\ ['.(v:foldend-v:foldstart+1).'\ lines]'
    endif
endfunction
command! -nargs=* GrepFoldDir :silent call My_GrepFold(1)
command! -nargs=* GrepFold :silent call My_GrepFold(0)



"" # spelling {{{1
highlight SpellBad term=underline gui=undercurl guisp=Red

" English spellchecking
set spl=en spell

" disable by default
set nospell


let g:myLang = 0
let g:myLangList = ['nospell', 'de', 'en']

function! MySpellLang()
    let g:myLang = g:myLang + 1
    if g:myLang >= len(g:myLangList) | let g:myLang = 0 | endif

    if g:myLang == 0 | setlocal nospell | endif
    if g:myLang == 1 | let &l:spelllang = g:myLangList[g:myLang] | setlocal spell | endif
    if g:myLang == 2 | let &l:spelllang = g:myLangList[g:myLang] | setlocal spell | endif
    echomsg 'language:' g:myLangList[g:myLang]
endfunction

" key-mapping:<F3> _Toggle spellcheck / switch languages
nmap <F3> :<C-U>call MySpellLang()<CR>





"" # cursor {{{1
set cursorline
set cursorcolumn

""" lines around the cursor
"set scrolloff=2    " minimal # of lines around the cursor
set scrolloff=3     " mininmal # of lines around the cursor
"set scrolloff=999  " cursor centered

"" cursor is dash when in insert mode
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"
"" optional reset cursor on start:
"augroup myCmds
"au!
"autocmd VimEnter * silent !echo -ne "\e[2 q"
"augroup END




"" # folding {{{1
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
noremap <Leader>zf :call MyToggleFold()<CR>

let g:myFoldMode = 0
let g:myFoldModes = ['marker', 'syntax', 'indent', 'diff', 'manual']
function! MyToggleFold()
    let g:myFoldMode = g:myFoldMode + 1
    if g:myFoldMode >= len(g:myFoldModes) | let g:myFoldMode = 0 | endif
    let &l:foldmethod = g:myFoldModes[g:myFoldMode]
    echo "foldmode: " &l:foldmethod
endfunction




"" # whitespaces {{{1
set list    " show listchars by default
" http://vim.wikia.com/wiki/Highlight_unwanted_spaces
"" function to switch between different listchars
let g:myWhitespaceMode = 0
let g:myWhitespaceModes = [ 
            \ ['nospace notab', 'set listchars=eol:$,tab:\ \ ,trail:·,nbsp:~,precedes:·,extends:·'],
            \ ['nospace',       'set listchars=eol:$,tab:>\ ,trail:·,nbsp:~,precedes:·,extends:·'],
            \ ['noeol',         'set listchars=tab:>\ ,trail:·,nbsp:~,precedes:·,extends:·'],
            \ ['all',           'set listchars=eol:$,tab:>\ ,trail:·,nbsp:~,precedes:·,extends:·,space:·']]
function! MyToggleWhitespace()
    let g:myWhitespaceMode = g:myWhitespaceMode + 1
    if g:myWhitespaceMode >= len(g:myWhitespaceModes) | let g:myWhitespaceMode = 0 | endif

    exec g:myWhitespaceModes[g:myWhitespaceMode][1]
    echo "whitespace mode: " g:myWhitespaceModes[g:myWhitespaceMode][0]
endfunction

exec g:myWhitespaceModes[0][1]
"" " keybindings
"" on/off
map <leader>W :set list!<CR>                        
"" toggle visible listchars
map <leader>w :call MyToggleWhitespace()<CR>

exec 'set fillchars=stl:\ ,stlnc:=,vert:\|,fold:\ ,diff:-'



"" # diff buffer {{{1
"" diff local buffer
function! s:MyDiffWithSaved()
    let filetype=&ft
    diffthis
    vnew | r # | normal! 1Gdd
    diffthis
    exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! MyDiffSaved call s:MyDiffWithSaved()

"" another way of diffing local changes
"  '!diff  --color=always % -'




"" # keybindings {{{1
"" https://blog.codepen.io/2014/02/21/vim-key-bindings/
"" https://hea-www.harvard.edu/~fine/Tech/vi.html
"" <silent> wont echo cmd

"" reload vimrc
map <leader>s :source ~/.vim/vimrc 
"map <leader>h yiw:help <C-R>"
map <leader>h :<C-u>execute 'help ' . expand('<cexpr>') 
map <leader>0 Y:<C-R>"<BS>

"" match current line
nnoremap <silent> <Leader>cl1 ml:execute 'match Search /\%'.line('.').'l/'<CR>
nnoremap <silent> <Leader>cl2 mm:execute '2match ColorColumn /\%'.line('.').'l/'<CR>
nnoremap <silent> <Leader>cl3 mn:execute '3match ErrorMsg /\%'.line('.').'l/'<CR>


" 1234 0xFFFFFFFF  '1234' '0xdeaddeef'  0b00101001 
function! MyConvertNumbers(numb)
    echom printf('dec: %d hex: 0x%x,0%04x,0x%08x bin: 0b%08b', a:numb, a:numb, a:numb, a:numb, a:numb)
endfunction
"map <localleader>cn yiw:call MyConvertNumbers(<C-R>")<CR>
map <localleader>cn :<C-u>execute 'call MyConvertNumbers(' . expand('<cexpr>') . ')'<CR>

" edit file with current path filled out
map <leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

"" global macro in slot p
map <F7> qp
map <F8> @p

map <leader>p "1p
map <leader>P "1P

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
"" ctrl+hjkl
imap <C-h> <C-o>h
imap <C-j> <C-o>j
imap <C-k> <C-o>k
imap <C-l> <C-o>l

"" in cmdline delete word
cmap <C-S-Left> <C-W>
cmap <C-S-j> <C-W>





"" # abbrev {{{1
" fast c-style comments
:ab #b /****************************************
:ab #e *****************************************/



"" # language-specific {{{1
"" ##    python {{{2
"autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType python set omnifunc=python3complete#Complete

""" syntastic
let g:syntastic_python_checkers=['pyflakes', 'flake8', 'pylint']
" let g:syntastic_python_flake8_args='--ignore=E501'  " E501 - long lines

" pydoc on 'K'
autocmd FileType python nnoremap <buffer> K :<C-u>execute "!pydoc " . expand("<cword>") <CR>

""" isort
let g:vim_isort_map = '<C-i>'






"" # make, execute {{{1
set makeprg=make\ -C\ ../build\ -j4
" Folding of (gnu)make output.
au BufReadPost quickfix setlocal foldmethod=marker
au BufReadPost quickfix setlocal foldmarker=Entering\ directory,Leaving\ directory
au BufReadPost quickfix map <buffer> <silent> zq zM:g/error:/normal zv<CR>
au BufReadPost quickfix map <buffer> <silent> zw zq:g/warning:/normal zv<CR>
au BufReadPost quickfix normal zq




nnoremap <F4> :make!<cr>
nnoremap <F5> :ConqueGDB

"" # plugin settings {{{1
"" ##  # colors {{{2
"" ###     # airline {{{3
"let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='serene'
let g:airline#extensions#tabline#show_buffers = 1
let g:airline_powerline_fonts = 1


"" ##  # completion {{{2
"" ###     # gutentags {{{3
let g:gutentags_define_advanced_commands=1 
let g:gutentags_resolve_symlinks=1
let g:gutentags_enabled=0
command! GutentagsGetEnabled :echo g:gutentags_enabled





"" ###     # YouCompleteMe {{{3
"" ####        # completion triggers {{{4
"" keybindings
let g:ycm_key_invoke_completion = '<C-Space>'
let g:ycm_key_list_select_completion=['<TAB>', '<Down>']
let g:ycm_key_list_previous_completion=['<S-TAB>', '<Up>']

"" disable in-buffer auto-completition popup
let g:ycm_min_num_of_chars_for_completion = 99  " disable identifier completer
"let g:ycm_auto_trigger = 0                      " disable identifier+semantic completer

let g:ycm_complete_in_comments = 1              " comment inline completion
let g:ycm_complete_in_strings = 1               " string completion

"" ####        # keybindings {{{4
nnoremap <leader>y :YcmCompleter GoTo<CR>
nnoremap <leader>Y :YcmCompleter GoTo
"" ####        # window behaviour {{{4

"" automatically close preview after selction
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1

"" open gotos in a vertical split
""[ 'same-buffer', 'horizontal-split', 'vertical-split', 'new-tab', 'new-or-existing-tab' ] 
let g:ycm_goto_buffer_command = 'same-buffer'
"" ####        # identifier sources {{{4
let g:ycm_collect_identifiers_from_tags_files = 1   " we want tags files to be used
let g:ycm_seed_identifiers_with_syntax = 0          " use vims syntax file to get language identifiers
"" ####        # ycm_extra_conf {{{4
let g:ycm_confirm_extra_conf = 0                    " automatically load extra conf when found recursively
let g:ycm_global_ycm_extra_conf='~/.vim/templates/ycm_extra_conf.py.kernel'   " otherwise load this
"let g:ycm_global_ycm_extra_conf='~/ycm_extra_conf.py.kernel'
"let g:ycm_global_ycm_extra_conf='~/ycm_extra_conf.py.android'

"" white- and blacklist for conf files (! is blocklist)
"let g:ycm_extra_conf_globlist = ['~/dev/*','!~/*']
"" ###     # tagbar {{{3
nmap <F10> :TagbarToggle<CR>
let g:tagbar_usearrows = 1



"" ##  # editing {{{2
"" ###     # tabular {{{3
nmap <leader>t :Tabular /
vmap <leader>t <ESC>:Tabular /


"" ##  # files {{{2
"" ###     # nerdtree {{{3
let NERDTreeHijackNetrw=1
let g:NERDTreeQuitOnOpen = 1

autocmd vimenter * if !argc() | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" keymapping:todo
nnoremap <silent> <F9> :NERDTreeToggle<CR>

"" ###     # ctrlp {{{3
" keymapping:<leader>p _ctrlp bufferlist
"nnoremap <leader>p :CtrlPBuffer<CR>
" keymapping:<leader>o _ctrlp open file
"nnoremap <leader>o :CtrlP<CR>
" let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:10,results:10'
let g:ctrlp_map='<c-p>'
let g:ctrlp_cmd='CtrlPBuffer'
" show hidden files
let g:ctrlp_show_hidden=1
" ignore paths
let g:ctrlp_custom_ignore='\v[\/]\.(git|hg|svn)$'
" reuse windows
let g:ctrlp_reuse_window='netrw\|help\|quickfix'
" don't reuse cache
let g:ctrlp_clear_cache_on_exit=1
" ctrlp cache dir
let g:ctrlp_cache_dir=$HOME.'/.vim/tmp/ctrlp'
" ctrlp history
let g:ctrlp_max_history=&history
" ctrlp follow symlinks
let g:ctrlp_follow_symlinks=1
" ctrlp regex search by default
let g:ctrlp_regexp_search=1
" ctrlp height 15
let g:ctrlp_max_height=15


"" ##  # git {{{2
"" ###     # git-gutter {{{3
let g:gitgutter_enabled = 0

"" ##  # ide {{{2
"" ###     # conque-gdb {{{3
let g:ConqueTerm_StartMessages = 0
let g:ConqueTerm_CloseOnEnd = 1
let g:ConqueTerm_Interrupt = '<C-g><C-c>'
let g:ConqueTerm_ReadUnfocused = 1
let g:ConqueGdb_Leader = '\\'



"" ###     # syntastic {{{3
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

let g:syntastic_enable_signs=1
let g:syntastic_auto_jump=0
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'
"let g:syntastic_disabled_filetypes=['html']

let g:syntastic_stl_format = '[%E{Err: %fe #%e}%B{, }%W{Warn: %fw #%w}]'



"" ##  # markup {{{2
"" ###     # markdown-fold {{{3
let g:markdown_fold_style = 'nested' " or 'stacked'
let g:markdown_fold_override_foldtext = 0

function! My_MarkdownToc()
    silent lvimgrep '^#' %
    vertical lopen
    let &winwidth=(&columns/2)
    set modifiable
    %s/\v^([^|]*\|){2,2} #//
    for i in range(1, line('$'))
        let l:line = getline(i)
        let l:header =  matchstr(l:line, '^#*')
        let l:length = len(l:header)
        let l:line = substitute(l:line, '\v^#*[ ]*', '', '')
        let l:line = substitute(l:line, '\v[ ]*#*$', '', '')
        let l:line = repeat(' ', (2 * l:length)) . l:line
        call setline(i, l:line)
    endfor
    set nomodified
    set nomodifiable
endfunction
command! -nargs=* MyMarkdownToc :silent call My_MarkdownToc()




"" # BREAK }}} }}} }}}



"" # incoming {{{1
"" disabled by default
if 0

endif

"" # some links {{{1
"" https://raw.githubusercontent.com/rasendubi/dotfiles/master/.vimrc
"" https://github.com/Valloric/YouCompleteMe#ubuntu-linux-x64
"" https://github.com/JBakamovic/yavide
"" https://vim.sourceforge.io/scripts/script.php?script_id=213
"" https://www.reddit.com/r/vim/comments/5iz4cw/making_a_vim_setup_for_cc/
"" test
"" # }}}


