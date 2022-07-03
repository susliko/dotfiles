local tla_ok, tla = pcall(require, "tla")
if not tla_ok then
  return
end

tla.setup()

local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
keymap("n", "<leader>tt", "<cmd>TlaTranslate<CR>", opts)
keymap("n", "<leader>tc", "<cmd>TlaCheck<CR>", opts)


local autoread_tla_group = vim.api.nvim_create_augroup("AutoReadTla", {})
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
  pattern = "*.tla",
  command = "if mode() != 'c' | checktime | endif",
  group = autoread_tla_group
})
