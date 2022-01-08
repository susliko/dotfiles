local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Switch language
keymap("i", "<C-l>", "<C-^>", opts)

-- Switch windows
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)
keymap("n", "<C-q>", "<C-w>q", opts)

-- Resize with arrows
keymap("n", "<Up>", ":resize -2<CR>", opts)
keymap("n", "<Down>", ":resize +2<CR>", opts)
keymap("n", "<Left>", ":vertical resize -6<CR>", opts)
keymap("n", "<Right>", ":vertical resize +6<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Reload config
keymap("n", "<Leader><CR>", "<cmd>source $MYVIMRC<CR>", { noremap = true })

-- Move around qflist
keymap("n", "]q", "<cmd>cnext<CR>zz", opts)
keymap("n", "[q", "<cmd>cprev<CR>zz", opts)

-- Disable search highlight
keymap("n", ",<space>", "<cmd>noh<CR>", opts)

-- Replace highlighted text
keymap("v", "<F2>", '"hy:%s/<C-r>h//gc<left><left><left>', opts)
keymap("n", "<F2>", ":%s/\\<<C-r><C-w>\\>/", opts)

-- Diagnostics
keymap("n", "<leader>e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
