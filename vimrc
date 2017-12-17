" title:  vimrc
"" author: bastian zeller
""
"" for documentation visit this file
"" - [](vim.md)
""

"" # notes and TODOs {{{1
"" ## notes {{{2
""    empty so far

"" ## TODO {{{2
"" - make nice list of available functions and keybindings
"" - check keybinding plausibility (recursive mapping, etc)

""  we have syntax scripts now. configure them to show nice colors

"" - ssh edit (tee, netrw??)

"" - snippets

"" }}} }}}

"" # minpac {{{1
if exists('*minpac#init')
    "" minpac itself.
    call minpac#init()
    call minpac#add('melantronica/minpac', {'type': 'opt'})

    "" Color
    call minpac#add('rafi/awesome-vim-colorschemes', {'type': 'opt'})
    call minpac#add('vim-airline/vim-airline-themes')
    call minpac#add('vim-airline/vim-airline')

    "" completion
    call minpac#add('majutsushi/tagbar')                    " tagbar
    call minpac#add('ludovicchabant/vim-gutentags')         " automatic tag creation
    call minpac#add('vim-scripts/OmniCppComplete')          " cpp omni completion
    call minpac#add('Valloric/YouCompleteMe', {'type': 'opt'}) "completion engine (very overdozed)
    call minpac#add('ervandew/supertab', {'type': 'opt'})   " make use of tab key
    "" editing
    call minpac#add('ConradIrwin/vim-bracketed-paste')      " when pasting from X disable formatting
    call minpac#add('tpope/vim-commentary')                 " comment code
    call minpac#add('tpope/vim-surround')                   " change surrounding
    call minpac#add('tpope/vim-repeat', {'type': 'opt'})    " create repeatable commands
    call minpac#add('tpope/vim-eunuch')                     " bash functions as commands
    call minpac#add('tommcdo/vim-lion')                     " align by character
    "" files
    call minpac#add('kien/ctrlp.vim', {'type': 'opt'})      " fuzzy finder
    call minpac#add('scrooloose/nerdtree')                  " file browser
    call minpac#add('Xuyuanp/nerdtree-git-plugin')          " git symbols
    ""
    call minpac#add('int3/vim-extradite')                   " git log with diff
    call minpac#add('tpope/vim-fugitive', {'type': 'opt'})  " everything git
    call minpac#add('airblade/vim-gitgutter', {'type': 'opt'})  " shot diff in the gutter
    "" grep
    call minpac#add('mileszs/ack.vim', {'type': 'opt'})     " search with ack
    call minpac#add('mhinz/vim-grepper')                    " various grep commands
    call minpac#add('romainl/vim-qf')                       " quickfix updates
    call minpac#add('romainl/vim-qlist')                    " quickfix updates
    "" IDE
    call minpac#add('w0rp/ale')                             " syntax check = linter
    call minpac#add('vim-scripts/Conque-GDB', {'type': 'opt'})  " gdb integration
    call minpac#add('tpope/vim-obsession', {'type': 'opt'}) " session management
    "" markup
    call minpac#add('tpope/vim-markdown', {'type': 'opt'})  " mardown 
    call minpac#add('nelstrom/vim-markdown-folding', {'type': 'opt'}) " fold rules for markdown
    call minpac#add('Rykka/riv.vim', {'type': 'opt'})       " reStructuredText
    ""
    call minpac#add('melantronica/vim-i3mux') " i3mux
endif

command! MyPackUpdate packadd minpac | source $MYVIMRC | call minpac#update() | helptags ~/.vim/pack/minpac 
command! MyPackClean  packadd minpac | source $MYVIMRC | call minpac#clean()
"" }}}

"" # general {{{1
let name = "Bastian Zeller"

set nocompatible            " turn off vi compatibility
set ttyfast                 " faster redeaw
set showcmd                 " show command

set lazyredraw

set confirm                 "

"" path for finding files, etc
set path+=$HOME/home/**,**
let g:DefaultPath=&path

",include,inc,
"    \ ..,../include,../inc,
"    \ ...,.../include,.../inc,
"    \ ...,.../include,.../inc,
"    \ /usr/include


filetype on                 " based on names
filetype indent on          " load indention ft based
filetype plugin indent on   " load ft based plugins

set encoding=utf-8          " fix encoding
set ff=unix                 " set file format
set shell=/bin/bash         " shell command

"let readline_has_bash=1     " bash support for readline
"let g:is_bash=1             " force bash

"" color map:
"" http://www.calmar.ws/vim/256-xterm-24bit-rgb-color-chart.html

"" leader
let mapleader=","
"let g:mapleader=","
let maplocalleader="\\"

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

"" if host gets resized we resize as well
autocmd VimResized * wincmd =

"" :B ghetto bufferlist
command! -nargs=? -bang B if <q-args> != '' | exe 'buffer '.<q-args> | else | ls<bang> | let buffer_nn=input('Choose buffer: ') | if buffer_nn != '' | exe buffer_nn != 0 ? 'buffer '.buffer_nn : 'enew' | endif | endif

"" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap W!! w !sudo tee > /dev/null %

"" List completions
set nowildmenu
"set nowildmenu
set wildignore=.svn,CVS,.git,.hg,*.o,*.a,*.mo,*.la,*.so,*.obj,*.swp,*.xpm,*.exe,*.rar
"set wildmode=longest:list,full  " completition style
set wildmode=list:longest,full  " completition style

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

set number          " line numbering
set numberwidth=4   " gutter = 4 columns
set relativenumber  " relative numbering
set showcmd         " show command at bottom

"" toggle relative numbers
nnoremap <silent> <leader>l :set rnu!<CR>

" highlight long lines
"set colorcolumn=80  " highlight col80
highlight ColorColumn ctermbg=127
call matchadd('ColorColumn', '\%79v', 127)

"" syntax
syntax on                   " syntax highlightling

"" indent
set nowrap          " no line wrapping
set tabstop=4       " tab = 4 columnsi
set softtabstop=4
set shiftwidth=4    " 4 columns reindent
set expandtab       " expand tabs to spaces
set smarttab
set smartindent     " indention up to syntax of code
set autoindent      " automatically transfer indention to next line
set textwidth=0     " TODO not sure if thats correct, but its prevents autolewline after 79
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
"nohlsearch          " why is this here??
set incsearch       " search while typing
set ignorecase      "
"set smartcase       " somehow annoying

augroup vimrc_todo
    au!
    " pre          \<\(@\|#\|/\|:\|\"\)
    " patterm
    " past
    au Syntax * syn match MyTodo "\<\(todo\|Todo\|ToDo\|TODO\|FIXME\|NOTE\|OPTIMIZE\|XXX\)\>"
        \ contained containedin=ALL
augroup END
hi def link MyTodo Todo   " todo
"hi def link MyTodo TodoRegion 


"" disable highliting temporary (afterddiwpp search)
" keymapping:<F2> _clear search highliting
noremap <silent> <F2> :noh<CR>
inoremap <silent> <F2> <C-o>:noh<CR>


function! Vimrc_Retab(tsin, tsout)

    "" Switch to hard tabs:
    set noexpandtab
    "" Set the tab stop to the current setting
    exec "set tabstop=".a:tsin
    retab!
    exec "set tabstop=".a:tsout
    " Go back to soft tabs
    set expandtab
    " Replace all the tabs in the current file to spaces
    retab
endfunction


command! -nargs=* MyRetab24 :silent call Vimrc_Retab(2, 4)
command! -nargs=* MyRetab42 :silent call Vimrc_Retab(4, 2)
"" # completion {{{1

set complete+=kspell

set omnifunc=syntaxcomplete#Complete

"" close preview after completion done
autocmd CompleteDone * pclose

function! Vimrc_UpdateTags()
    execute ":!ctags -R --languages=C++ --c++-kinds=+p --fields=+iaS --extra=+q ./"
    echohl StatusLine | echo "C/C++ tag updated" | echohl None
endfunction

"nmap <C-}> :exe ":tj /" . expand("<cexpr>")<CR>
nmap <localleader>] :exe ":tj /" . expand("<cexpr>")<CR>


function! Vimrc_cscope(func)
  let tmp1=&grepprg
  let tmp2=&grepformat
  set grepformat=%f\ %*[a-zA-Z_0-9]\ %l\ %m
  set grepprg=cscope\ -R\ -L\ -3
  exe "grep ".a:func
  exe "set grepprg=".escape(tmp1,' ')
  exe "set grepformat=".escape(tmp2, ' ')
  redraw!
endfunction

command! -nargs=* MyCscope :silent call Vimrc_cscope("<args>")

"" ## cscope {{{2
if has("cscope")

    """"""""""""" Standard cscope/vim boilerplate

    " use both cscope and ctag for 'ctrl-]', ':ta', and 'vim -t'
    set cscopetag

    " check cscope for definition of a symbol before checking ctags: set to 1
    " if you want the reverse search order.
    set csto=1

    " add any cscope database in current directory
    if filereadable("cscope.out")
        cs add cscope.out
    " else add the database pointed to by environment variable
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif

    " show msg when any other cscope db added
    set cscopeverbose

    """"""""""""" My cscope/vim key mappings
    "
    " The following maps all invoke one of the following cscope search types:
    "
    "   's'   symbol: find all references to the token under cursor
    "   'g'   global: find global definition(s) of the token under cursor
    "   'c'   calls:  find all calls to the function name under cursor
    "   't'   text:   find all instances of the text under cursor
    "   'e'   egrep:  egrep search for the word under cursor
    "   'f'   file:   open the filename under cursor
    "   'i'   includes: find files that include the filename under cursor
    "   'd'   called: find functions that function under cursor calls
    "
    " Below are three sets of the maps: one set that just jumps to your
    " search result, one that splits the existing vim window horizontally and
    " diplays your search result in the new window, and one that does the same
    " thing, but does a vertical split instead (vim 6 only).
    "
    " I've used CTRL-\ and CTRL-@ as the starting keys for these maps, as it's
    " unlikely that you need their default mappings (CTRL-\'s default use is
    " as part of CTRL-\ CTRL-N typemap, which basically just does the same
    " thing as hitting 'escape': CTRL-@ doesn't seem to have any default use).
    " If you don't like using 'CTRL-@' or CTRL-\, , you can change some or all
    " of these maps to use other keys.  One likely candidate is 'CTRL-_'
    " (which also maps to CTRL-/, which is easier to type).  By default it is
    " used to switch between Hebrew and English keyboard mode.
    "
    " All of the maps involving the <cfile> macro use '^<cfile>$': this is so
    " that searches over '#include <time.h>" return only references to
    " 'time.h', and not 'sys/time.h', etc. (by default cscope will return all
    " files that contain 'time.h' as part of their name).


    " To do the first type of search, hit 'CTRL-\', followed by one of the
    " cscope search types above (s,g,c,t,e,f,i,d).  The result of your cscope
    " search will be displayed in the current window.  You can use CTRL-T to
    " go back to where you were before the search.
    "

    nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
    nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>

    set cscopequickfix=s-,c-,d-,i-,t-,e-,a-
    " Using 'CTRL-spacebar' (intepreted as CTRL-@ by vim) then a search type
    " makes the vim window split horizontally, with search result displayed in
    " the new window.
    "
    " (Note: earlier versions of vim may not have the :scs command, but it
    " can be simulated roughly via:
    "    nmap <C-@>s <C-W><C-S> :cs find s <C-R>=expand("<cword>")<CR><CR>

    nmap <C-@>s :scs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@>g :scs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@>c :scs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@>t :scs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@>e :scs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@>f :scs find f <C-R>=expand("<cfile>")<CR><CR>
    nmap <C-@>i :scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nmap <C-@>d :scs find d <C-R>=expand("<cword>")<CR><CR>


    " Hitting CTRL-space *twice* before the search type does a vertical
    " split instead of a horizontal one (vim 6 and up only)
    "
    " (Note: you may wish to put a 'set splitright' in your .vimrc
    " if you prefer the new window on the right instead of the left

    nmap <C-@><C-@>s :vert scs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>g :vert scs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>c :vert scs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>t :vert scs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>e :vert scs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>f :vert scs find f <C-R>=expand("<cfile>")<CR><CR>
    nmap <C-@><C-@>i :vert scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nmap <C-@><C-@>d :vert scs find d <C-R>=expand("<cword>")<CR><CR>

endif

"" # grep {{{1

" This rewires n and N to do the blink for the next match
nnoremap <silent> n   n:call Vimrc_HLNext(0.1)<cr>
nnoremap <silent> N   N:call Vimrc_HLNext(0.1)<cr>
noremap <silent> <F2> :noh<cr>:call Vimrc_HLNext_delete()<cr>
inoremap <silent> <F2> <C-o>:noh<cr>:call Vimrc_HLNext_delete()<cr>


let g:vimrc_last_match = 0

nohlsearch


function! Vimrc_HLNext_delete()
    if g:vimrc_last_match > 0
        call matchdelete(g:vimrc_last_match)
    endif
endfunction

" highlight the match in red
function! Vimrc_HLNext (blinktime)
    if g:vimrc_last_match > 0
        call matchdelete(g:vimrc_last_match)
    endif
    highlight WhiteOnRed ctermfg=white ctermbg=red
    let [bufnum, lnum, col, off] = getpos('.')
    let matchlen = strlen(matchstr(strpart(getline('.'),col-1),@/))
    let target_pat = '\c\%#\%('.@/.'\)'
    let g:vimrc_last_match = matchadd('WhiteOnRed', target_pat, 101)
"    I dont want the blinking anymore
"    redraw
"    exec 'sleep ' . float2nr(a:blinktime * 1000) . 'm'
"    call matchdelete(last_match)
"    redraw
endfunction

function! Vimrc_GrepAgenda(func)
  let tmp1=&grepprg
  let tmp2=&grepformat
"  set grepformat=%f\ %*[a-zA-Z_0-9]\ %l\ %m
"  set grepformat=%f:%l:%m,%f-%l-%m,%f:%l%m
  set grepprg=~/.vim/helper/todo-agenda.sh
  exe "grep! ".a:func
  let &grepprg=tmp1
  let &grepformat=tmp2
  copen
  redraw!
endfunction
command! -nargs=* MyTodoAgenda :silent call Vimrc_GrepAgenda("<args>")


function! Vimrc_GrepTodo(func)
  let tmp1=&grepprg
  let tmp2=&grepformat
"  set grepformat=%f\ %*[a-zA-Z_0-9]\ %l\ %m
"  set grepformat=%f:%l:%m,%f-%l-%m,%f:%l%m,%f  %l%m
  set grepprg=~/.vim/helper/todo-grep.sh
  exe "grep! ".a:func
  let &grepprg=tmp1
  let &grepformat=tmp2
  copen
  redraw!
endfunction
command! -nargs=* MyTodoGrep :silent call Vimrc_GrepTodo("<args>")

command! -nargs=* MyNotes :drop ~/doc/notes/incoming/notes.md
command! -nargs=* MyNotesv :drop ~/.vim/vimrc | :b +/##\ TODO .vim/vimrc

function! Vimrc_GrepFold(dir)
    setlocal foldlevel=0
    setlocal foldmethod=expr
    setlocal foldexpr=matchstr(getline(v:lnum),'^[^\|]\\+')==#matchstr(getline(v:lnum+1),'^[^\|]\\+')?1:'<1'
    setlocal foldtext=matchstr(getline(v:foldstart),'^[^\|]\\+').'\ ['.(v:foldend-v:foldstart+1).'\ lines]'
    if a:dir
        setlocal foldexpr=matchstr(substitute(getline(v:lnum),'\|.*','',''),'^.*/')==#matchstr(substitute(getline(v:lnum+1),'\|.*','',''),'^.*/')?1:'<1'
        setlocal foldtext=matchstr(substitute(getline(v:foldstart),'\|.*','',''),'^.*/').'\ ['.(v:foldend-v:foldstart+1).'\ lines]'
    endif
endfunction
command! -nargs=* MyGrepFoldDir :silent call Vimrc_GrepFold(1)
command! -nargs=* MyGrepFold :silent call Vimrc_GrepFold(0)



"" # spelling {{{1
highlight SpellBad term=underline gui=undercurl guisp=Red

" English spellchecking
set spl=en spell

" disable by default
set nospell


let g:vimrc_spell_lang = 0
let g:vimrc_spell_lang_list = ['nospell', 'de', 'en']

function! Vimrc_SpellLang()
    let g:vimrc_spell_lang = g:vimrc_spell_lang + 1
    if g:vimrc_spell_lang >= len(g:vimrc_spell_lang_list) | let g:vimrc_spell_lang= 0 | endif

    if g:vimrc_spell_lang == 0 | setlocal nospell | endif
    if g:vimrc_spell_lang == 1 | let &l:spelllang = g:vimrc_spell_lang_list[g:vimrc_spell_lang] | setlocal spell | endif
    if g:vimrc_spell_lang == 2 | let &l:spelllang = g:vimrc_spell_lang_list[g:vimrc_spell_lang] | setlocal spell | endif
    echomsg 'language:' g:vimrc_spell_lang_list[g:vimrc_spell_lang]
endfunction

" key-mapping:<F3> _Toggle spellcheck / switch languages
map <F3> :<C-U>call Vimrc_SpellLang()<CR>
imap <F3> <C-o>:<C-U>call Vimrc_SpellLang()<CR>





"" # cursor {{{1
set cursorline
set cursorcolumn

""" lines around the cursor
"set scrolloff=2    " minimal # of lines around the cursor
set scrolloff=3     " mininmal # of lines around the cursor
"set scrolloff=999  " cursor centered
set ttimeoutlen=0
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
function! Vimrc_FoldText()
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
set foldtext=Vimrc_FoldText()

set nofoldenable        " we start without folding
set foldlevel=1         " if enabled we want to have foldlevel 1 expanded
set foldmethod=marker   " default mode is marker, so {{{ }}} gives us folding

"" Alt-z toggles folds
nnoremap <A-z> za
inoremap <A-z> <C-o>za
vnoremap <A-z> zf

"" toggle through different foldmethods
noremap <Leader>zf :call Vimrc_ToggleFold()<CR>

let g:vimrc_fold_mode = 0
let g:vimrc_fold_modes = ['marker', 'syntax', 'indent', 'diff', 'manual']
function! Vimrc_ToggleFold()
    let g:vimrc_fold_mode = g:vimrc_fold_mode + 1
    if g:vimrc_fold_mode >= len(g:vimrc_fold_modes) | let g:vimrc_fold_mode = 0 | endif
    let &l:foldmethod = g:vimrc_fold_modes[g:vimrc_fold_mode]
    echo "foldmode: " &l:foldmethod
endfunction




"" # whitespaces {{{1
set list    " show listchars by default
" http://vim.wikia.com/wiki/Highlight_unwanted_spaces
"" function to switch between different listchars
let g:vimrc_whitespace_mode = 0
let g:vimrc_whitespace_mode_list = [
            \ ['nospace notab', 'set listchars=eol:$,tab:\ \ ,trail:·,nbsp:~,precedes:·,extends:·'],
            \ ['nospace',       'set listchars=eol:$,tab:>\ ,trail:·,nbsp:~,precedes:·,extends:·'],
            \ ['noeol',         'set listchars=tab:>\ ,trail:·,nbsp:~,precedes:·,extends:·'],
            \ ['all',           'set listchars=eol:$,tab:>\ ,trail:·,nbsp:~,precedes:·,extends:·,space:·']]
function! Vimrc_ToggleWhitespace()
    let g:vimrc_whitespace_mode = g:vimrc_whitespace_mode + 1
    if g:vimrc_whitespace_mode >= len(g:vimrc_whitespace_modes) | let g:vimrc_whitespace_mode = 0 | endif

    exec g:vimrc_whitespace_mode_list[g:vimrc_whitespace_mode][1]
    echo "whitespace mode: " g:vimrc_whitespace_mode_list[g:vimrc_whitespace_mode][0]
endfunction

exec g:vimrc_whitespace_mode_list[0][1]
"" " keybindings
"" on/off
map <leader>W :set list!<CR>
"" toggle visible listchars
map <leader>w :call Vimrc_ToggleWhitespace()<CR>

exec 'set fillchars=stl:\ ,stlnc:=,vert:\|,fold:\ ,diff:-'



"" # diff buffer {{{1
"" diff local buffer
function! s:Vimrc_DiffWithSaved()
    let filetype=&ft
    diffthis
    vnew | r # | normal! 1Gdd
    diffthis
    exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! MyDiffSaved call s:Vimrc_DiffWithSaved()

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
nnoremap <silent> <Leader>m1 ml:execute 'match Search /\%'.line('.').'l/'<CR>
nnoremap <silent> <Leader>m2 mm:execute '2match ColorColumn /\%'.line('.').'l/'<CR>
nnoremap <silent> <Leader>m3 mn:execute '3match ErrorMsg /\%'.line('.').'l/'<CR>

command! -nargs=* MyTime r !date \+\%R
command! -nargs=* MyDate r !date \+\%F
command! -nargs=* MyDateTime r !date \+'\%F \%R'

" 1234 0xFFFFFFFF  '1234' '0xdeaddeef'  0b00101001
function! Vimrc_ConvertNumbers(numb)
    echom printf('dec: %d hex: 0x%x,0%04x,0x%08x bin: 0b%08b', a:numb, a:numb, a:numb, a:numb, a:numb)
endfunction
"map <localleader>cn yiw:call MyConvertNumbers(<C-R>")<CR>
map <localleader>cn :<C-u>execute 'call Vimrc_ConvertNumbers(' . expand('<cexpr>') . ')'<CR>

" edit file with current path filled out
map <leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

"" global macro in slot p
map <F7> qq
imap <F7> <C-o>qq
map <F8> @q
imap <F8> <C-o>@q

"" paste register 1 (cycles last 10)
map <leader>p "1p
map <leader>P "1P

"" shift+arrow selection
nmap <S-Up> vk
nmap <S-Down> vj
nmap <S-Left> vh
nmap <S-Right> vl
vmap <S-Up> k
vmap <S-Down> j
vmap <S-Left> h
vmap <S-Right> l

imap <S-Up> <Esc>vk
imap <S-Down> <Esc>vj
imap <S-Left> <Esc>vh
imap <S-Right> <Esc>vl


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

"" we have to remap
nnoremap <leader><C-l> :redraw!<CR> :redraw!<CR>:redraw!<CR>

"" move between windows with alt hjkl
exec "set <A-h>=\eh"
noremap <A-h> <C-w>h
inoremap <A-h> <C-o><C-w>h
exec "set <A-j>=\ej"
noremap <A-j> <C-w>j
inoremap <A-j> <C-o><C-w>j
exec "set <A-k>=\ek"
noremap <A-k> <C-w>k
inoremap <A-k> <C-o><C-w>k
exec "set <A-l>=\el"
noremap <A-l> <C-w>l
inoremap <A-l> <C-o><C-w>l


"" window management
let g:vimrc_is_fullscreen=0
function! Vimrc_ToggleCurrentWindowAsTab(preserve)

    let l:fullscreenPos = getcurpos()
    if(g:vimrc_is_fullscreen)
        tabclose
        let g:vimrc_is_fullscreen=0
    else
        tabedit %
        let g:vimrc_is_fullscreen=1
    endif

    "silent ! tmux resize-pane -Z
    silent ! i3-msg fullscreen

    if(a:preserve)
        call setpos(".", l:fullscreenPos)
    endif
endfunction
nmap <C-w>e :call Vimrc_ToggleCurrentWindowAsTab(1)<CR>
nmap <C-w>E :call Vimrc_ToggleCurrentWindowAsTab(0)<CR>

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
"set makeprg=make\ -C\ ../build\ -j4
" Folding of (gnu)make output.
au BufReadPost quickfix setlocal foldmethod=marker
au BufReadPost quickfix setlocal foldmarker=Entering\ directory,Leaving\ directory
au BufReadPost quickfix map <buffer> <silent> zq zM:g/error:/normal zv<CR>
au BufReadPost quickfix map <buffer> <silent> zw zq:g/warning:/normal zv<CR>
au BufReadPost quickfix normal zq




noremap <F5> :ConqueGDB
inoremap <F5> <C-o>:ConqueGDB
noremap <F4> :make!<cr>
inoremap <F4> <C-o>:make!<cr>

"" # plugin settings {{{1
"" ##  # colors {{{2
"" ###     # airline {{{3
"let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='tentacle_molokai'
let g:airline#extensions#tabline#show_buffers = 1
let g:airline_powerline_fonts = 1


"" ##  # completion {{{2
"" ###     # gutentags {{{3
let g:gutentags_define_advanced_commands=1
let g:gutentags_resolve_symlinks=1
let g:gutentags_enabled=1
command! MyGutentagsGetEnabled :echo g:gutentags_enabled

"" we never generate without write
let g:gutentags_generate_on_missing=0
let g:gutentags_generate_on_new=0

"" no defualt project roots
let g:gutentags_add_default_project_roots=0

let g:gutentags_project_root=['tags','cscope.out']


"" ###     # YouCompleteMe {{{3
if 0
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
endif


"" ###     # tagbar {{{3
map <F10> :TagbarToggle<CR>
imap <F10> <C-o>:TagbarToggle<CR>
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
inoremap <silent> <F9> <C-o>:NERDTreeToggle<CR>

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

let g:ConqueGdb_ToggleBreak = g:ConqueGdb_Leader . 'b'

map <localleader>b :<C-u>execute 'ConqueGdbCommand b ' . expand('%:p') . ':' . line('.') <CR>

map <localleader>bb :call conque_gdb#toggle_breakpoint(expand("%:p"), line("."))<CR>
"map <localleader>b :call conque_gdb#command("break " . expand("%:p") . ":" . line("."))<CR>
"map <localleader>b :call conque_gdb#command("clear " . expand("%:p") . ":" . line("."))<CR>
map <localleader>bc :call conque_gdb#command("continue")<CR>
map <localleader>br :call conque_gdb#command("run")<CR>
map <localleader>bn :call conque_gdb#command("next")<CR>
map <localleader>bs :call conque_gdb#command("step")<CR>
map <localleader>bf :call conque_gdb#command("finish")<CR>
map <localleader>bt :call conque_gdb#command("backtrace")<CR>
map <localleader>bp :call conque_gdb#print_word(expand("<cexpr>"))<CR>

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

"" ###     # ALE syntax check {{{3

"let g:ale_fixers = {
"\   'cpp': ['clang-format'],
"\   'c': ['clang-format'],
"\ }

" Write this in your vimrc file
let g:ale_lint_on_text_changed = 'never'
" You can disable this option too
" if you don't want linters to run on opening a file
let g:ale_lint_on_enter = 0






"" ##  # markup {{{2
"" ###     # markdown-fold {{{3
let g:markdown_fold_style = 'nested' " or 'stacked'
let g:markdown_fold_override_foldtext = 0

function! Vimrc_MarkdownToc()
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
command! -nargs=* MyMarkdownToc :silent call Vimrc_MarkdownToc()




"" # BREAK }}} }}} }}}

"" # incoming {{{1
"" disabled by default
if 0

endif

"" # some links {{{1
"" https://github.com/easymotion/vim-easymotion
"" https://github.com/SirVer/ultisnips
"" https://github.com/tpope/vim-abolish
"" https://github.com/wellle/targets.vim
"" # }}}



