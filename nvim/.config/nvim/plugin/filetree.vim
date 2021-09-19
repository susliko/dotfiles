" undo tree
nnoremap <F5> :UndotreeToggle<CR>

" NERDTree file navigator
nnoremap <leader>nn :NvimTreeToggle<CR>
nnoremap <leader>nf :NvimTreeFindFile<CR>

set termguicolors " this variable must be enabled for colors to be applied properly
let g:nvim_tree_gitignore=0
let g:nvim_tree_side='right'
let g:nvim_tree_disable_netrw = 0
let g:nvim_tree_hijack_netrw = 0

