local tla_ok, tla = pcall(require, "tla")
if not tla_ok then
	return
end

tla.setup()

vim.api.nvim_set_keymap("n", "<leader>tc", '<cmd>lua require("tla").check()<cr>', {})
vim.api.nvim_set_keymap("n", "<leader>tr", '<cmd>lua require("tla").translate()<cr>', {})

