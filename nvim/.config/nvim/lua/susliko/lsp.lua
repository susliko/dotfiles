local M = {}

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

local sumneko_binary_path = vim.fn.exepath('lua-language-server')
local sumneko_root_path = vim.fn.fnamemodify(sumneko_binary_path, ':h:h:h')

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

local function setup_sumneko_lua ()
  require'lspconfig'.sumneko_lua.setup {
    flags = {
      debounce_text_changes = 150,
    },
    capabilities=capabilities,
    cmd = {sumneko_binary_path, "-E", sumneko_root_path .. "/main.lua"},
    settings = {
      Lua = {
        runtime = {
          version = 'LuaJIT',  -- Because use for Neovim
          path = runtime_path, -- Setup your lua path
        },
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = {'vim'},
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = vim.api.nvim_get_runtime_file("", true),
        },
        -- Do not send telemetry data containing a randomized but unique identifier
        telemetry = {
          enable = false,
        },
      },
    },
  }
end

local function setup_metals()
  Metals_config = require("metals").bare_config()

  Metals_config.settings = {
    showImplicitArguments = true,
    showInferredType = true,
    fallbackScalaVersion = "2.13.6",
  }

  Metals_config.init_options.statusBarProvider = "on"

  Metals_config.on_attach = function(_, _)
    vim.cmd([[autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()]])
    vim.cmd([[autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()]])
    vim.cmd([[autocmd BufEnter,CursorHold,InsertLeave <buffer> lua vim.lsp.codelens.refresh()]])
  end

  vim.cmd([[augroup lsp]])
  vim.cmd([[autocmd!]])
  vim.cmd([[autocmd FileType scala setlocal omnifunc=v:lua.vim.lsp.omnifunc]])
  vim.cmd([[autocmd FileType scala,sbt lua require("metals").initialize_or_attach(Metals_config)]])
  vim.cmd([[augroup end]])
end

M.setup = function()
  local lsp_config = require("lspconfig")

  setup_sumneko_lua()
  setup_metals()
  lsp_config.dockerls.setup({})
  lsp_config.html.setup({})
  lsp_config.cssls.setup({})
  lsp_config.jdtls.setup({})
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

  require("lsp_signature").setup({hint_enable = false})
  -- Uncomment for trace logs from neovim
  -- vim.lsp.set_log_level('trace')
end

return M
