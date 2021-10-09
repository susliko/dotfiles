local cmd = vim.cmd
local g = vim.g

local function map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- LSP
map("n", "<leader>ws", '<cmd>lua require"metals".hover_worksheet()<CR>')
map("n", "<leader>a" , '<cmd>lua require"metals".open_all_diagnostics()<CR>')
map("n", "<leader>tt", [[<cmd>lua require("metals.tvp").toggle_tree_view()<CR>]])
map("n", "<leader>tr", [[<cmd>lua require("metals.tvp").reveal_in_tree()<CR>]])
map("n", "<leader>fm", [[<cmd>lua require("telescope").extensions.metals.commands()<cr>]])

-- completion related settings
-- This is similiar to what I use
require("compe").setup({
  enabled = true,
  debug = false,
  min_length = 1,

  source = {
    path = true,
    buffer = true,
    vsnip = {
      filetypes = { "scala", "sbt", "java" },
    },
    nvim_lsp = {
      priority = 1000,
      filetypes = { "scala", "sbt", "java" },
    },
  },
})

map("i", "<S-Tab>", 'pumvisible() ? "\\<C-p>" : "\\<Tab>"', { expr = true })
map("i", "<Tab>", 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', { expr = true })
map("i", "<CR>", 'compe#confirm("\\<CR>")', { expr = true })

-- LSP
cmd([[augroup lsp]])
cmd([[autocmd!]])
cmd([[autocmd FileType scala setlocal omnifunc=v:lua.vim.lsp.omnifunc]])
cmd([[autocmd FileType scala,sbt lua require("metals").initialize_or_attach(metals_config)]])
cmd([[augroup end]])

-- Need for symbol highlights to work correctly
vim.cmd([[hi! link LspReferenceText CursorColumn]])
vim.cmd([[hi! link LspReferenceRead CursorColumn]])
vim.cmd([[hi! link LspReferenceWrite CursorColumn]])
----------------------------------
-- LSP Setup ---------------------
----------------------------------
metals_config = require("metals").bare_config

-- Example of settings
metals_config.settings = {
  showImplicitArguments = true,
  showInferredType = true,
  fallbackScalaVersion = "2.13.6"
}

-- I *highly* recommend setting statusBarProvider to true, however if you do,
-- you *have* to have a setting to display this in your statusline or else
-- you'll not see any messages from metals. There is more info in the help
-- docs about this
-- metals_config.init_options.statusBarProvider = "on"

-- Example if you are including snippets
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

metals_config.capabilities = capabilities
