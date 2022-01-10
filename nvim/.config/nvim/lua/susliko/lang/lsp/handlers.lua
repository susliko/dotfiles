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

local function lsp_highlight_document(client)
	if client.resolved_capabilities.document_highlight then
		vim.api.nvim_exec(
			[[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]],
			false
		)
	end
end

local function lsp_document_codelens(client)
	if client.resolved_capabilities.code_lens then
		vim.cmd([[
      augroup lsp_document_codelens
      autocmd! * <buffer>
        autocmd BufEnter,CursorHold,InsertLeave <buffer> lua vim.lsp.codelens.refresh()
      augroup end
    ]])
	end
end

local function lsp_format_document()
	vim.cmd([[ 
    command! Format execute 'lua vim.lsp.buf.formatting()' 
    augroup lsp_document_format
      autocmd! * <buffer>
      autocmd BufWritePre <buffer> Format
    augroup END
  ]])
end

local function lsp_keymaps(bufnr)
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
	keymap(bufnr, "n", "<leader>dl", "<cmd>lua vim.diagnostic.set_loclist()<CR>", opts)
	keymap(bufnr, "n", "[c", "<cmd>lua vim.diagnostic.goto_prev { wrap = false }<CR>", opts)
	keymap(bufnr, "n", "]c", "<cmd>lua vim.diagnostic.goto_next { wrap = false }<CR>", opts)
	keymap(bufnr, "n", "<leader>sh", [[<cmd>lua vim.lsp.buf.signature_help()<CR>]], opts)
end

local function attach(client, bufnr)
	lsp_keymaps(bufnr)
	lsp_highlight_document(client)
	lsp_document_codelens(client)
	lsp_format_document()
	require("lsp_signature").on_attach({ hint_enable = false }, bufnr)
end

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
