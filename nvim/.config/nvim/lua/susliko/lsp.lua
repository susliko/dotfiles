local M = {}

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

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

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

local sumneko_lua_opts = {
  flags = {
    debounce_text_changes = 150,
  },
  capabilities=capabilities,
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        path = runtime_path,
      },
      diagnostics = {
        globals = {'vim'},
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
      },
      telemetry = {
        enable = false,
      },
    },
  },
}

local jsonls_opts = {
    commands = {
      Format = {
        function()
          vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line("$"), 0 })
        end,
      },
    },
  }

M.setup = function()
  local lsp_installer = require("nvim-lsp-installer")
    lsp_installer.on_server_ready(function(server)
    local opts = {}
    if server.name == "sumneko_lua" then opts = sumneko_lua_opts end
    if server.name == "jsonls" then opts = jsonls_opts end
    server:setup(opts)
  end)

  setup_metals()
  require("lsp_signature").setup({hint_enable = false})
  -- Uncomment for trace logs from neovim
  -- vim.lsp.set_log_level('trace')
end

return M
