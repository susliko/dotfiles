local hop_ok, hop = pcall(require, "hop")
if not hop_ok then
	return
end

local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

hop.setup()
keymap("n", "s", "<cmd>HopChar1<CR>", opts)
