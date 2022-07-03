vim.g.vimtex_view_method = "zathura"

local tex_group = vim.api.nvim_create_augroup("TeXSettings", {})
vim.api.nvim_create_autocmd("FileType", {
  pattern = "tex",
  command = "set keymap=russian-jcukenwin | set iminsert=0 | set imsearch=-1",
  group = tex_group
})
