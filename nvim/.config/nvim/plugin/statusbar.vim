" airline bar
au User AirlineAfterInit  :let g:airline_section_z = airline#section#create(['%3p%% %L:%1v'])
let g:airline_section_x=''
lua << EOF
vim.g["airline_section_y"]=vim.g["metals_status"] or ""
EOF
let g:airline_skip_empty_sections = 1
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
