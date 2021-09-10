nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fq <cmd>Telescope quickfix<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fs :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})<CR>
nnoremap <leader>frc :lua require('susliko.telescope').search_dotfiles()<CR>

