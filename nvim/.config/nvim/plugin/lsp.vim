lua require('susliko.cmp').setup()
lua require('susliko.lsp').setup()

nnoremap <silent> gd          <cmd>lua require('telescope.builtin').lsp_definitions()<CR>
nnoremap <silent> gtd         <cmd>lua require('telescope.builtin').lsp_type_definitions()<CR>
nnoremap <silent> gi          <cmd>lua require('telescope.builtin').lsp_implementations()<CR>
nnoremap <silent> gr          <cmd>lua require('telescope.builtin').lsp_references()<CR>
nnoremap <silent> gs          <cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>
nnoremap <silent> <leader>fm  <cmd>lua require('telescope').extensions.metals.commands()<CR>
nnoremap <silent> gws         <cmd>lua require('susliko.telescope').lsp_workspace_symbols()<CR>
nnoremap <silent> <leader>ca  <cmd>lua vim.lsp.buf.code_action<CR>
nnoremap <silent> K           <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <leader>rn  <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent> <leader>d   <cmd>lua vim.lsp.diagnostic.set_loclist()<CR>
nnoremap <silent> [c          <cmd>lua vim.lsp.diagnostic.goto_prev { wrap = false }<CR>
nnoremap <silent> ]c          <cmd>lua vim.lsp.diagnostic.goto_next { wrap = false }<CR>
nnoremap <silent> <leader>e  <cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>
nnoremap <silent> <leader>ws  <cmd>lua require('metals').hover_worksheet()<CR>
nnoremap <silent> <leader>a   <cmd>lua require('metals').open_all_diagnostics()<CR>
nnoremap <silent> <leader>tt" <cmd>lua require('metals.tvp').toggle_tree_view()<CR>
nnoremap <silent> <leader>tr" <cmd>lua require('metals.tvp').reveal_in_tree()<CR>
nnoremap <silent> <leader>ml  <cmd>lua require('metals').toggle_logs()<CR>

autocmd BufWritePre *.scala lua vim.lsp.buf.formatting()
autocmd BufWritePre *.lua lua vim.lsp.buf.formatting()
autocmd BufWritePre *.html lua vim.lsp.buf.formatting()
autocmd BufWritePre *.css lua vim.lsp.buf.formatting()

