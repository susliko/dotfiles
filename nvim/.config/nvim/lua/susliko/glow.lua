-- markdown
local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

keymap("n", "<leader>mm", "<cmd>Glow<CR>", opts)
