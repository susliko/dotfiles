lua require('susliko.telescope')

nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fq <cmd>Telescope quickfix<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fc <cmd>Telescope command_history<cr>
nnoremap <leader>frc :lua require('susliko.telescope').search_dotfiles()<cr>

