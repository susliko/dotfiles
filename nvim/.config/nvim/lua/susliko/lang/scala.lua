local metals_ok, metals = pcall(require, "metals")
if not metals_ok then
  return
end
local dap_ok, dap = pcall(require, "dap")
if not dap_ok then
  return
end

local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_buf_set_keymap

Metals_config = metals.bare_config()

Metals_config.settings = {
  showImplicitArguments = true,
  showInferredType = true,
  fallbackScalaVersion = "2.13.7",
}

Metals_config.init_options.statusBarProvider = "on"

local function set_keymaps(bufnr)
  keymap(bufnr, "n", "<leader>ws", "<cmd>lua require('metals').hover_worksheet()<CR>", opts)
  keymap(bufnr, "n", "<leader>tt", "<cmd>lua require('metals.tvp').toggle_tree_view()<CR>", opts)
  keymap(bufnr, "n", "<leader>tr", "<cmd>lua require('metals.tvp').reveal_in_tree()<CR>", opts)
  keymap(bufnr, "n", "<leader>ml", "<cmd>lua require('metals').toggle_logs()<CR>", opts)
  keymap(bufnr, "n", "<leader>fm", "<cmd>lua require('telescope').extensions.metals.commands()<CR>", opts)
  keymap(bufnr, "v", "K", "<Esc><cmd>lua require('metals').type_of_range()<CR>", opts)
end

local function set_dap(bufnr)
  dap.configurations.scala = {
    {
      type = "scala",
      request = "launch",
      name = "RunOrTest",
      metals = {
        runType = "runOrTestFile",
        --args = { "firstArg", "secondArg", "thirdArg" }, -- here just as an example
      },
    },
    {
      type = "scala",
      request = "launch",
      name = "Test Target",
      metals = {
        runType = "testTarget",
      },
    },
    {
      type = "scala",
      request = "launch",
      name = "Run main",
      metals = {
        runType = "run",
      },
    },
  }
  keymap(bufnr, "n", "<leader>dc", [[<cmd>lua require("dap").continue()<CR>]], opts)
  keymap(bufnr, "n", "<leader>dr", [[<cmd>lua require("dap").repl.toggle()<CR>]], opts)
  keymap(
    bufnr,
    "n",
    "<leader>ds",
    [[<cmd>lua require("dap.ui.widgets").sidebar(require("dap.ui.widgets").scopes).toggle()<CR>]],
    opts
  )
  keymap(bufnr, "n", "<leader>dK", [[<cmd>lua require("dap.ui.widgets").hover()<CR>]], opts)
  keymap(bufnr, "n", "<leader>dt", [[<cmd>lua require("dap").toggle_breakpoint()<CR>]], opts)
  keymap(bufnr, "n", "<leader>dso", [[<cmd>lua require("dap").step_over()<CR>]], opts)
  keymap(bufnr, "n", "<leader>dsi", [[<cmd>lua require("dap").step_into()<CR>]], opts)
  keymap(bufnr, "n", "<leader>dl", [[<cmd>lua require("dap").run_last()<CR>]], opts)
  require("metals").setup_dap()
end

local function attach(client, bufnr)
  require("susliko.lang.lsp.handlers").on_attach(client, bufnr)
  set_keymaps(bufnr)
  set_dap(bufnr)
end

Metals_config.on_attach = function(client, bufnr)
  local attach_ok, result = pcall(attach, client, bufnr)
  if not attach_ok then
    local msg = string.format("Metals on_attach failure: %s", result)
    vim.notify(msg, vim.log.levels.WARN)
  end
end

-- Autocmd that will actually be in charging of starting the whole thing
local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  -- NOTE: You may or may not want java included here. You will need it if you
  -- want basic Java support but it may also conflict if you are using
  -- something like nvim-jdtls which also works on a java filetype autocmd.
  pattern = { "scala", "sbt", "java" },
  callback = function()
    require("metals").initialize_or_attach(Metals_config)
  end,
  group = nvim_metals_group,
})
