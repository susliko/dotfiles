" nnoremap <leader>ga :Git fetch --all<CR>
" nnoremap <leader>grom :Git rebase origin/master<CR>
" nnoremap <leader>gmom :Git rebase origin/master<CR>
" nnoremap <leader>gc :Git commit<CR>


" nmap <leader>gj :diffget //3<CR>
" nmap <leader>gf :diffget //2<CR>
" nmap <leader>gg :G<CR>

lua require('gitsigns').setup()
