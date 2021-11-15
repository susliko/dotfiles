local actions = require("telescope.actions")

local trim_path_vowels = function(_, path)
  local sep = require("telescope.utils").get_separator()
  local filename = require("telescope.utils").path_tail(path)
  local filepath = string.gsub(path, sep .. filename, "")
  if (filepath == filename) then
    return filename
  else
    local short_filepath = string.gsub(filepath, "[AEYUIOaeyuio]", "")
    return string.format("%s/%s", short_filepath, filename)
  end
end

require("telescope").setup({
    defaults = {
        file_ignore_patterns = {'.git/.*'},
        path_display = trim_path_vowels,
        file_sorter = require("telescope.sorters").get_fzy_sorter,
        prompt_prefix = " >",
        color_devicons = true,

        layout_strategy = "vertical",
        layout_config = {
          vertical = {
            width = 0.97,
            height = 0.97,
            preview_height = 0.5,
          }
        },
        mappings = {
            i = {
                ["<C-x>"] = false,
                ["<C-q>"] = actions.send_to_qflist,
                ["<esc>"] = actions.close,
								["<C-h>"] = function (prompt_bufnr)
									R("telescope").extensions.hop._hop(prompt_bufnr, {callback = actions.select_default})
								end,
                ["<C-k>"] = function(prompt_bufnr)
                  local opts = {
                    callback = actions.toggle_selection,
                    loop_callback = actions.send_selected_to_qflist,
                  }
                  require("telescope").extensions.hop._hop_loop(prompt_bufnr, opts)
                end,
            },
        },
    },
    extensions = {
        fzy_native = {
            override_generic_sorter = false,
            override_file_sorter = true,
        },
        hop = {
          -- keys define your hop keys in order; defaults to roughly lower- and uppercased home row
          keys = {"a", "s", "d", "f", "g", "h", "j", "k", "l", ";",
                  "q", "w", "e", "r", "t", "y", "u", "i", "o", "p",
                  "A", "S", "D", "F", "G", "H", "J", "K", "L", ":",
                  "Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P", },

          -- Highlight groups to link to signs and lines; the below configuration refers to demo
          -- sign_hl typically only defines foreground to possibly be combined with line_hl
          sign_hl = { "WarningMsg", "Title" },

          -- optional, typically a table of two highlight groups that are alternated between
          line_hl = { "CursorLine", "Normal" },

          -- options specific to `hop_loop`
          -- true temporarily disables Telescope selection highlighting
          clear_selection_hl = false,
          -- highlight hopped to entry with telescope selection highlight
          -- note: mutually exclusive with `clear_selection_hl`
          trace_entry = true,
          -- jump to entry where hoop loop was started from
          reset_selection = true,
        },
    }
})
require('telescope').load_extension('fzy_native')

local M = {}
M.search_dotfiles = function()
    require("telescope.builtin").find_files({
        prompt_title = "< VimRC >",
        cwd = vim.env.DOTFILES,
        hidden = true,
    })
end

M.lsp_workspace_symbols = function()
  local input = vim.fn.input("Query: ")
  vim.api.nvim_command("normal :esc<CR>")
  if not input or #input == 0 then
    return
  end
  require("telescope.builtin").lsp_workspace_symbols({ query = input })
end

return M
