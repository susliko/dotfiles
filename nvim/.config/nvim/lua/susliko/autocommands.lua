local new_augroup = function(name) vim.api.nvim_create_augroup(name, {}) end
local new_autocmd = vim.api.nvim_create_autocmd

-- General
local general_group = new_augroup("GeneralSettings")
new_autocmd("FileType", {
  pattern = {"qf", "help", "man", "lspinfo" },
  command = "nnoremap <silent> <buffer> q :close<CR>",
  group = general_group
})
new_autocmd("TextYankPost", {
  pattern = "*",
  command = "silent!lua require('vim.highlight').on_yank({higroup = 'Search', timeout = 200})",
  group = general_group
})
new_autocmd("BufWinEnter", {
  pattern = "*",
  command = ":set formatoptions-=cro",
  group = general_group
})
new_autocmd("FileType", {
  pattern = "qf",
  command = "set nobuflisted",
  group = general_group
})

-- Markdown
local markdown_group = new_augroup("MarkdownSettings")
new_autocmd("FileType", {
  pattern = "markdown",
  command = "setlocal wrap | setlocal spell",
  group = markdown_group
})

