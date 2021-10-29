local M = {}

M.setup = function()
  local lsp_config = require("lspconfig")
  local capabilities = vim.lsp.protocol.make_client_capabilities()

  lsp_config.util.default_config = vim.tbl_extend("force", lsp_config.util.default_config, {
    capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities),
  })

  metals_config = require("metals").bare_config

  metals_config.settings = {
    showImplicitArguments = true,
    showInferredType = true,
    fallbackScalaVersion = "2.13.6",
  }

  metals_config.init_options.statusBarProvider = "on"
  metals_config.capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)


  metals_config.on_attach = function(client, bufnr)
    vim.cmd([[autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()]])
    vim.cmd([[autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()]])
    vim.cmd([[autocmd BufEnter,CursorHold,InsertLeave <buffer> lua vim.lsp.codelens.refresh()]])
  end

  lsp_config.dockerls.setup({})
  lsp_config.html.setup({})
  lsp_config.cssls.setup({})
  lsp_config.jsonls.setup({
    commands = {
      Format = {
        function()
          vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line("$"), 0 })
        end,
      },
    },
  })
  lsp_config.tsserver.setup({})

  vim.cmd([[augroup lsp]])
  vim.cmd([[autocmd!]])
  vim.cmd([[autocmd FileType scala setlocal omnifunc=v:lua.vim.lsp.omnifunc]])
  vim.cmd([[autocmd FileType scala,sbt lua require("metals").initialize_or_attach(metals_config)]])
  vim.cmd([[augroup end]])

  -- Uncomment for trace logs from neovim
  --vim.lsp.set_log_level('trace')
end

return M
