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
set hid

highlight lCursor guifg=NONE guibg=Cyan

call plug#begin('~/.vim/plugged')
Plug 'JamshedVesuna/vim-markdown-preview'
Plug 'akinsho/nvim-toggleterm.lua'
Plug 'ellisonleao/glow.nvim'
Plug 'florentc/vim-tla'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/vim-vsnip'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'kristijanhusak/orgmode.nvim', { 'branch' : 'tree-sitter' }
Plug 'kristijanhusak/vim-dadbod-ui'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'kyazdani42/nvim-web-devicons' 
Plug 'lervag/vimtex'
Plug 'lewis6991/gitsigns.nvim'
Plug 'mbbill/undotree'
Plug 'mechatroner/rainbow_csv'
Plug 'morhetz/gruvbox'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'onsails/lspkind-nvim'
Plug 'phaazon/hop.nvim'
Plug 'ray-x/lsp_signature.nvim'
Plug 'rmagatti/auto-session'
Plug 'scalameta/nvim-metals'
Plug 'sheerun/vim-polyglot'
Plug 'shumphrey/fugitive-gitlab.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dadbod'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-scriptease'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-utils/vim-man'
Plug '~/programming/public/tla.nvim'
call plug#end()

" Esc remap
" inoremap jk <Esc>

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

" hop
lua require'hop'.setup()
nnoremap s :HopChar1<CR>
