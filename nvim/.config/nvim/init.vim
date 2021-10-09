" basics
let mapleader=" "
set encoding=utf-8
set relativenumber
set number
filetype plugin on
syntax on
set tabstop=2 softtabstop=2
set shiftwidth=2
set expandtab
set noswapfile
set smartcase
set smartindent
set keymap=russian-jcukenwin
set iminsert=0
set imsearch=0
set scrolloff=8
set hidden " If hidden is not set, TextEdit might fail.
set nobackup " Some servers have issues with backup files
set nowritebackup
set updatetime=300 " You will have a bad experience with diagnostic messages with the default 4000.
set shortmess+=c " Don't give |ins-completion-menu| messages.
set shortmess-=F " Ensure autocmd works for Filetype
set signcolumn=yes " Always show signcolumns
set splitright
set completeopt=menuone,noselect,noinsert
set termguicolors " this variable must be enabled for colors to be applied properly

highlight lCursor guifg=NONE guibg=Cyan

call plug#begin('~/.vim/plugged')
Plug 'neovim/nvim-lspconfig'
Plug 'lervag/vimtex'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'morhetz/gruvbox'
Plug 'sheerun/vim-polyglot'
Plug 'kien/ctrlp.vim'
Plug 'mechatroner/rainbow_csv'
Plug 'florentc/vim-tla'
Plug 'JamshedVesuna/vim-markdown-preview'
Plug 'vim-airline/vim-airline'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
Plug 'rmagatti/auto-session'
Plug '~/programming/public/tla.nvim'
Plug 'folke/lua-dev.nvim'
Plug 'tpope/vim-fugitive'
Plug 'mbbill/undotree'
Plug 'vim-utils/vim-man'
Plug 'lewis6991/gitsigns.nvim'
Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'kyazdani42/nvim-tree.lua'
Plug 'shumphrey/fugitive-gitlab.vim'
Plug 'tpope/vim-dadbod'
Plug 'justinmk/vim-sneak'
Plug 's1n7ax/nvim-terminal'
Plug 'akinsho/nvim-toggleterm.lua'
Plug 'kristijanhusak/orgmode.nvim'
Plug 'ellisonleao/glow.nvim'
Plug 'tpope/vim-scriptease'
Plug 'scalameta/nvim-metals'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/nvim-compe'
call plug#end()

" Esc remap
inoremap jk <Esc>

" language switch
inoremap <C-l> <C-^>

" windows operations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
nnoremap <C-Q> <C-W><C-Q>
nnoremap <C-w>z <C-w>\|<C-w>\_
nnoremap <silent> <Left> :vertical resize -6<CR>
nnoremap <silent> <Right> :vertical resize +6<CR>
nnoremap <silent> <Up> :resize -2<CR>
nnoremap <silent> <Down> :resize +2<CR>

" reloading config
nnoremap <Leader><CR> :so ~/.config/nvim/init.vim<CR>

" theme
let g:gruvbox_guisp_fallback = "bg"
colorscheme gruvbox
set background=dark    

" pretty json
nnoremap <Leader>jj :%!jq<CR>

" quickfix lists
nnoremap ]q :cnext<CR>zz
nnoremap [q :cprev<CR>zz

" weather!
command WM :term curl wttr.in/moscow

" highlight yanked
au TextYankPost * lua vim.highlight.on_yank {higroup="IncSearch", timeout=150, on_visual=true}

" no higlight
nnoremap ,<space> :noh<CR>


lua << EOF
function _G.dump(...)
    local objects = vim.tbl_map(vim.inspect, {...})
    print(unpack(objects))
    return ...
end
EOF

" markdown
let g:glow_binary_path = "/usr/local/bin"
noremap <leader>mm :Glow<CR>

" nvim-lsp Mappings
nnoremap <silent> gd          <cmd>lua require('telescope.builtin').lsp_definitions()<CR>
nnoremap <silent> gtd         <cmd>lua require('telescope.builtin').lsp_type_definitions()<CR>
nnoremap <silent> K           <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gi          <cmd>lua require('telescope.builtin').lsp_implementations()<CR>
nnoremap <silent> gr          <cmd>lua require('telescope.builtin').lsp_references()<CR>
nnoremap <silent> gs         <cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>
nnoremap <silent> gws         <cmd>lua require('susliko.telescope').lsp_workspace_symbols()<CR>
nnoremap <silent> <leader>rn  <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent> <leader>ca  <cmd>lua require('telescope.builtin').lsp_code_actions()<CR>
nnoremap <silent> <leader>d   <cmd>lua vim.lsp.diagnostic.set_loclist()<CR>
nnoremap <silent> [c          <cmd>lua vim.lsp.diagnostic.goto_prev { wrap = false }<CR>
nnoremap <silent> ]c          <cmd>lua vim.lsp.diagnostic.goto_next { wrap = false }<CR>