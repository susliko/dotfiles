lua require('susliko.telescope')

nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files({hidden=true})<cr>
nnoremap <leader>fl <cmd>lua require('telescope.builtin').resume()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fq <cmd>Telescope quickfix<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fc <cmd>Telescope command_history<cr>
nnoremap <leader>frc :lua require('susliko.telescope').search_dotfiles()<cr>

