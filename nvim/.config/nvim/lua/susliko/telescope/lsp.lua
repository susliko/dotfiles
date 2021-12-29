local M = {}

M.workspace_symbols = function()
  local input = vim.fn.input('Query: ')
  vim.api.nvim_command('normal :esc<CR>')
  if not input or #input == 0 then
    return
  end
  require('telescope.builtin').lsp_workspace_symbols({ query = input })
end

return M
