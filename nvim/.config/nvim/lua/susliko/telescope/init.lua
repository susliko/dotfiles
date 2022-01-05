local telescope_ok, telescope = pcall(require, 'telescope')
if not telescope_ok then return end

local actions = require('telescope.actions')
local sorters = require('telescope.sorters')

require('susliko.telescope.keymaps')
require('susliko.telescope.lsp')
local utils = require('susliko.telescope.utils')
local hop = require('susliko.telescope.hop')

require('telescope').setup({
    defaults = {
        file_ignore_patterns = {'.git/.*', 'node_modules'},
        path_display = utils.trim_path_vowels,
        file_sorter = sorters.get_fzy_sorter,
        prompt_prefix = ' 🔭 ',
        color_devicons = true,
        layout_strategy = 'vertical',
        layout_config = {
          vertical = {
            width = 0.97,
            height = 0.97,
            preview_height = 0.5,
          }
        },
        mappings = {
            i = {
                ["<C-h>"] = actions.cycle_history_prev,
                ["<C-l>"] = actions.cycle_history_next,
                ['<C-q>'] = actions.send_to_qflist,
                ['<esc>'] = actions.close,
								['<C-j>'] = hop.actions.select
            },
        },
        vimgrep_arguments = {
          'rg',
          '--color=never',
          '--no-heading',
          '--with-filename',
          '--line-number',
          '--column',
          '--smart-case',
          '--hidden' -- grep in hidden files
        },
    },
    extensions = {
        fzy_native = {
            override_generic_sorter = false,
            override_file_sorter = true,
        },
        hop = hop.settings,
        ["ui-select"] = require("telescope.themes").get_dropdown(),
    }
})

pcall(telescope.load_extension, 'fzy_native')
pcall(telescope.load_extension, 'scaladex')
pcall(telescope.load_extension, 'ui-select')


local M = {}
M.search_dotfiles = function()
  require('telescope.builtin').find_files({
    prompt_title = '< VimRC >',
    cwd = vim.env.DOTFILES,
    hidden = true,
  })
end

return M
