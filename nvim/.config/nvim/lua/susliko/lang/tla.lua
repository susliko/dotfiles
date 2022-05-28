local tla_ok, tla = pcall(require, "tla")
if not tla_ok then
	return
end

tla.setup()

local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
keymap("n", "<leader>tt", "<cmd>TlaTranslate<CR>", opts)
keymap("n", "<leader>tc", "<cmd>TlaCheck<CR>", opts)


