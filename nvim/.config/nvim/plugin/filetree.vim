lua << EOF
require'nvim-tree'.setup {
  view = {
    width = 45,
    side = 'right',
  }
}
EOF

" NERDTree file navigator
nnoremap <leader>nn :NvimTreeToggle<CR>
nnoremap <leader>nf :NvimTreeFindFile<CR>

set termguicolors " this variable must be enabled for colors to be applied properly

