local M = {}

M.setup = function()
  local signs = {
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn", text = "" },
    { name = "DiagnosticSignHint", text = "" },
    { name = "DiagnosticSignInfo", text = "" },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end

  local config = {
    -- disable virtual text
    virtual_text = false,
    -- show signs
    signs = {
      active = signs,
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focusable = false,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  }

  vim.diagnostic.config(config)

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
  })
end

local function create_highlight_autocmds(client, bufnr)
  if client.resolved_capabilities.document_highlight then
    local group = vim.api.nvim_create_augroup("LspDocumentHiglight", {})
    vim.api.nvim_create_autocmd("CursorHold", {
      buffer = bufnr,
      callback = function() vim.lsp.buf.document_highlight() end,
      group = group
    })
    vim.api.nvim_create_autocmd("CursorMoved", {
      buffer = bufnr,
      callback = function() vim.lsp.buf.clear_references() end,
      group = group
    })
  end
end

local function create_codelens_autocomds(client, bufnr)
  if client.resolved_capabilities.code_lens then
    local group = vim.api.nvim_create_augroup("LspCodelens", { clear = true })
    vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
      buffer = bufnr,
      callback = function() vim.lsp.codelens.refresh() end,
      group = group
    })
  end
end

local function create_format_autocmds(client, bufnr)
  if client.resolved_capabilities.document_formatting then
    local group = vim.api.nvim_create_augroup("LspCodelens", { clear = true })
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      callback = function() vim.lsp.buf.formatting_sync() end,
      group = group
    })
  end
end

local function create_keymaps(bufnr)
  local opts = { noremap = true, silent = true }
  local keymap = vim.api.nvim_buf_set_keymap

  keymap(bufnr, "n", "gd", "<cmd>lua require('telescope.builtin').lsp_definitions()<CR>", opts)
  keymap(bufnr, "n", "gtd", "<cmd>lua require('telescope.builtin').lsp_type_definitions()<CR>", opts)
  keymap(bufnr, "n", "gi", "<cmd>lua require('telescope.builtin').lsp_implementations()<CR>", opts)
  keymap(bufnr, "n", "gr", "<cmd>lua require('telescope.builtin').lsp_references()<CR>", opts)
  keymap(bufnr, "n", "gs", "<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>", opts)
  keymap(bufnr, "n", "gws", "<cmd>lua require('susliko.telescope.lsp').workspace_symbols()<CR>", opts)
  keymap(bufnr, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  keymap(bufnr, "n", "<leader>cl", "<cmd>lua vim.lsp.codelens.run()<CR>", opts)
  keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  keymap(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  keymap(bufnr, "n", "<leader>ad", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
  keymap(bufnr, "n", "<leader>ae", "<cmd>lua vim.diagnostic.setloclist({severity = 'E'})<CR>", opts)
  keymap(bufnr, "n", "<leader>aw", "<cmd>lua vim.diagnostic.setloclist({severity = 'W'})<CR>", opts)
  keymap(bufnr, "n", "[c", "<cmd>lua vim.diagnostic.goto_prev { wrap = false }<CR>", opts)
  keymap(bufnr, "n", "]c", "<cmd>lua vim.diagnostic.goto_next { wrap = false }<CR>", opts)
  keymap(bufnr, "n", "<leader>sh", [[<cmd>lua vim.lsp.buf.signature_help()<CR>]], opts)
end

local function attach(client, bufnr)
  create_keymaps(bufnr)
  create_highlight_autocmds(client, bufnr)
  create_codelens_autocomds(client, bufnr)
  require("lsp_signature").on_attach({ hint_enable = false }, bufnr)
end

M.create_format_autocmds = create_format_autocmds

M.on_attach = function(client, bufnr)
  local attach_ok, result = pcall(attach, client, bufnr)
  if not attach_ok then
    local msg = string.format("LSP attach failed: %s", result)
    vim.notify(msg, vim.log.levels.WARN)
  end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

local cmp_nvim_lsp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_ok then
  return
end

M.capabilities = cmp_nvim_lsp.update_capabilities(capabilities)

return M
