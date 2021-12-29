local metals_ok, metals = pcall(require, "metals")
if not metals_ok then return end

Metals_config = metals.bare_config()

Metals_config.settings = {
  showImplicitArguments = true,
  showInferredType = true,
  fallbackScalaVersion = "2.13.6",
}

Metals_config.init_options.statusBarProvider = "on"

local function set_keymaps(bufnr)
  local opts = { noremap = true, silent = true }
  local keymap = vim.api.nvim_buf_set_keymap
  keymap(bufnr, "n", "<leader>ws", "<cmd>lua require('metals').hover_worksheet()<CR>", opts)
  keymap(bufnr, "n", "<leader>tt", "<cmd>lua require('metals.tvp').toggle_tree_view()<CR>", opts)
  keymap(bufnr, "n", "<leader>tr", "<cmd>lua require('metals.tvp').reveal_in_tree()<CR>", opts)
  keymap(bufnr, "n", "<leader>ml", "<cmd>lua require('metals').toggle_logs()<CR>", opts)
  keymap(bufnr, "n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
  keymap(bufnr, "n", "<leader>fm", "<cmd>lua require('telescope').extensions.metals.commands()<CR>", opts)
end

Metals_config.on_attach = function(client, bufnr)
  require('susliko.lsp.handlers').on_attach(client, bufnr)
  set_keymaps(bufnr)
end

vim.cmd[[
  augroup metals_start
  autocmd!
    autocmd FileType scala setlocal omnifunc=v:lua.vim.lsp.omnifunc
    autocmd FileType scala,sbt lua require("metals").initialize_or_attach(Metals_config)
  augroup end
]]

