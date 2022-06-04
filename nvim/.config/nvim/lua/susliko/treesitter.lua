local ts_ok, configs = pcall(require, "nvim-treesitter.configs")

if not ts_ok then
  return
end

local ts_parsers_ok, parsers = pcall(require, "nvim-treesitter.parsers")
if not ts_parsers_ok then
  return
end

local parser_configs = parsers.get_parser_configs()

configs.setup({
  ensure_installed = "all",
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
  sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
  ignore_install = { "swift" }, -- List of parsers to ignore installing
  autopairs = {
    enable = true,
  },
  highlight = {
    enable = true,
    disable = {}, -- Remove this to use TS highlighter for some of the highlights (Experimental)
    additional_vim_regex_highlighting = true,
  },
  rainbow = {
    enable = true,
    extended_mode = true, -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
    max_file_lines = 1000, -- Do not enable for files with more than 1000 lines, int
    colors = { -- kanagawa colors: https://github.com/rebelot/kanagawa.nvim/blob/master/lua/kanagawa/colors.lua
      "#957FB8",
      "#7E9CD8",
      "#9CABCA",
      "#7FB4CA",
      "#A3D4D5",
      "#7AA89F",
    }
  }
})
