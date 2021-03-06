" Color palette
let s:gui_dark_gray = '#303030'
let s:cterm_dark_gray = 0
let s:gui_med_gray_hi = '#444444'
let s:cterm_med_gray_hi = 235 
let s:gui_med_gray_lo = '#3a3a3a'
let s:cterm_med_gray_lo = 232
let s:gui_light_gray = '#b2b2b2'
let s:cterm_light_gray = 249

let s:gui_green = '#005f87'
let s:cterm_black = 0        " 135
let s:gui_blue = '#87afd7'
let s:cterm_pink_ = 161
let s:gui_purple = '#afafd7'
let s:cterm_purple = 144
let s:gui_orange = '#ffaf87'
let s:cterm_orange = 216
let s:gui_red = '#d78787'
let s:cterm_red = 216
let s:gui_pink = '#d7afd7'
let s:cterm_green_ = 118

let g:airline#themes#tentacle_molokai#palette = {}



	" Mode map
	let g:airline_mode_map = {
		\ '__' : '--',
		\ 'n'  : 'N',
		\ 'i'  : 'I',
		\ 'R'  : 'R',
		\ 'c'  : 'C',
		\ 'v'  : 'V',
		\ 'V'  : 'V-L',
		\ '' : 'V-B',
		\ 's'  : 'S',
		\ 'S'  : 'S-L',
		\ '' : 'S-B',
		\ 't'  : 'T',
		\ }



" Normal mode
let s:N1 = [s:gui_dark_gray, s:gui_green, 255, s:cterm_black]
let s:N2 = [s:gui_light_gray, s:gui_med_gray_lo, s:cterm_light_gray, s:cterm_med_gray_lo]
let s:N3 = [s:gui_light_gray, s:gui_med_gray_hi, s:cterm_light_gray, s:cterm_med_gray_hi] " inside text
let g:airline#themes#tentacle_molokai#palette.normal = airline#themes#generate_color_map(s:N1, s:N2, s:N3)
let g:airline#themes#tentacle_molokai#palette.normal_modified = {
      \ 'airline_c': [s:gui_orange, s:gui_med_gray_hi, s:cterm_orange, s:cterm_med_gray_hi, ''],
      \ }

" Insert mode
let g:airline#themes#tentacle_molokai#palette.insert = {
      \ 'airline_a': [s:gui_dark_gray, s:gui_orange, 0, s:cterm_pink_, ''],
      \ 'airline_b': [s:gui_dark_gray, s:gui_orange, 255, 0, ''],
      \ 'airline_c': [s:gui_red, s:gui_med_gray_hi, s:cterm_red, s:cterm_med_gray_hi, ''],
      \ }

let g:airline#themes#tentacle_molokai#palette.insert_modified = copy(g:airline#themes#angr#palette.normal_modified)


" Replace mode
let g:airline#themes#tentacle_molokai#palette.replace = {
      \ 'airline_a': [s:gui_dark_gray, s:gui_red, s:cterm_red, 0, ''],
      \ 'airline_c': [s:gui_red, s:gui_med_gray_hi, s:cterm_red, s:cterm_med_gray_hi, ''],
      \ }
let g:airline#themes#tentacle_molokai#palette.replace_modified = copy(g:airline#themes#angr#palette.insert_modified)


" Visual mode
let g:airline#themes#tentacle_molokai#palette.visual = {
      \ 'airline_a': [s:gui_dark_gray, s:gui_red, 0, s:cterm_green_, ''],
      \ 'airline_c': [s:gui_red, s:gui_med_gray_hi, s:cterm_red, s:cterm_med_gray_hi, ''],
      \ }
let g:airline#themes#tentacle_molokai#palette.visual_modified = copy(g:airline#themes#angr#palette.insert_modified)


" Inactive window
let s:IA = [s:gui_light_gray, s:gui_med_gray_hi, s:cterm_light_gray, s:cterm_med_gray_hi, '']
let g:airline#themes#tentacle_molokai#palette.inactive = airline#themes#generate_color_map(s:IA, s:IA, s:IA)
let g:airline#themes#tentacle_molokai#palette.inactive_modified = {
      \ 'airline_c': [s:gui_orange, '', s:cterm_orange, '', ''],
      \ }

" Warnings
let s:ER = airline#themes#get_highlight2(['ErrorMsg', 'bg'], ['ErrorMsg', 'fg'], 'bold')
let g:airline#themes#tentacle_molokai#palette.normal.airline_warning = [
 \ s:ER[1], s:ER[0], s:ER[3], s:ER[2]
 \ ]
let g:airline#themes#tentacle_molokai#palette.normal_modified.airline_warning =
\ g:airline#themes#tentacle_molokai#palette.normal.airline_warning
let g:airline#themes#tentacle_molokai#palette.insert.airline_warning =
\ g:airline#themes#tentacle_molokai#palette.normal.airline_warning
let g:airline#themes#tentacle_molokai#palette.insert_modified.airline_warning =
\ g:airline#themes#tentacle_molokai#palette.normal.airline_warning
let g:airline#themes#tentacle_molokai#palette.visual.airline_warning =
\ g:airline#themes#tentacle_molokai#palette.normal.airline_warning
let g:airline#themes#tentacle_molokai#palette.visual_modified.airline_warning =
\ g:airline#themes#tentacle_molokai#palette.normal.airline_warning
let g:airline#themes#tentacle_molokai#palette.replace.airline_warning =
\ g:airline#themes#tentacle_molokai#palette.normal.airline_warning
let g:airline#themes#tentacle_molokai#palette.replace_modified.airline_warning =
\ g:airline#themes#tentacle_molokai#palette.normal.airline_warning

" Errors
let g:airline#themes#tentacle_molokai#palette.normal.airline_error = [
 \ s:ER[1], s:ER[0], s:ER[3], s:ER[2]
 \ ]
let g:airline#themes#tentacle_molokai#palette.normal_modified.airline_error =
\ g:airline#themes#tentacle_molokai#palette.normal.airline_error
let g:airline#themes#tentacle_molokai#palette.insert.airline_error =
\ g:airline#themes#tentacle_molokai#palette.normal.airline_error
let g:airline#themes#tentacle_molokai#palette.insert_modified.airline_error =
\ g:airline#themes#tentacle_molokai#palette.normal.airline_error
let g:airline#themes#tentacle_molokai#palette.visual.airline_error =
\ g:airline#themes#tentacle_molokai#palette.normal.airline_error
let g:airline#themes#tentacle_molokai#palette.visual_modified.airline_error =
\ g:airline#themes#tentacle_molokai#palette.normal.airline_error
let g:airline#themes#tentacle_molokai#palette.replace.airline_error =
\ g:airline#themes#tentacle_molokai#palette.normal.airline_error
let g:airline#themes#tentacle_molokai#palette.replace_modified.airline_error =
\ g:airline#themes#tentacle_molokai#palette.normal.airline_error


