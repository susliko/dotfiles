local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

keymap("n", "<leader>ff", "<cmd>lua require('telescope.builtin').find_files({hidden=true})<cr>", opts)
keymap("n", "<leader>fl", "<cmd>lua require('telescope.builtin').resume()<cr>", opts)
keymap("n", "<leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<cr>", opts)
keymap("n", "<leader>fq", "<cmd>Telescope quickfix<cr>", opts)
keymap("n", "<leader>fb", "<cmd>Telescope buffers<cr>", opts)
keymap("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", opts)
keymap("n", "<leader>fc", "<cmd>Telescope command_history<cr>", opts)
keymap("n", "<leader>fp", "<cmd>Telescope projects<cr>", opts)
keymap("n", "<leader>frc", "<cmd>lua require('susliko.telescope').search_dotfiles()<cr>", opts)
keymap("n", "<leader>si", "<cmd>lua require('telescope').extensions.scaladex.scaladex.search()<cr>", opts)
