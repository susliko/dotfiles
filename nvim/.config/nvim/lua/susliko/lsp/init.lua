local lsp_config_ok, _ = pcall(require, 'lspconfig')
if not lsp_config_ok then return end
local lsp_signature_ok, _ = pcall(require, "lsp_signature")
if not lsp_signature_ok then return end
local telescope_ok, _ = pcall(require, "telescope")
if not telescope_ok then return end

require'susliko.lsp.handlers'
require'susliko.lsp.installer'
require'susliko.lsp.metals'

-- Uncomment for trace logs from neovim
-- vim.lsp.set_log_level('trace')
