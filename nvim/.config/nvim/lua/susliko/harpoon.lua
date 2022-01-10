local harpoon_ok, harpoon = pcall(require, "harpoon")
if not harpoon_ok then
	return
end

harpoon.setup()

local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

harpoon.setup({
	menu = {
		width = 100,
	},
})

keymap("n", "<leader>hh", '<cmd>lua require("harpoon.ui").toggle_quick_menu()<cr>', opts)
keymap("n", "<leader>hf", '<cmd>lua require("harpoon.mark").add_file()<cr>', opts)
