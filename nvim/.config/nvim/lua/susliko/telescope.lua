local actions = require("telescope.actions")
local transform_mod = require('telescope.actions.mt').transform_mod

local custom_actions = transform_mod({
  toggle_hidden = function(prompt_bufnr)
    -- actions.close(prompt_bufnr)
    picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
    picker:refresh(require("telescope.finders").JobFinder:new({}), {})
  end,
})

local foo = transform_mod({
  bar = function(prompt_bufnr)
    print("This function ran after another action. Prompt_bufnr: " .. prompt_bufnr)
    actions.close(prompt_bufnr)
    -- Enter your function logic here. You can take inspiration from lua/telescope/actions.lua
  end,
})

require("telescope").setup({
    defaults = {
        file_ignore_patterns = {'.git/.*'},
        path_display = function(opts, path)
          local sep = require("telescope.utils").get_separator()
          local filename = require("telescope.utils").path_tail(path)
          local filepath = string.gsub(path, sep .. filename, "")
          if  (filepath == filename) then
            return filename
          else 
            local short_filepath = string.gsub(filepath, "[AEYUIOaeyuio]", "")
            return string.format("%s/%s", short_filepath, filename)
          end
        end,
        file_sorter = require("telescope.sorters").get_fzy_sorter,
        prompt_prefix = " >",
        color_devicons = true,

        file_previewer = require("telescope.previewers").vim_buffer_cat.new,
        grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
        qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,

        mappings = {
            i = {
                ["<C-x>"] = false,
                ["<C-q>"] = actions.send_to_qflist,
                ["<esc>"] = actions.close,
                ["<C-w>"] = custom_actions.toggle_hidden,
            },
        },
    },
    extensions = {
        fzy_native = {
            override_generic_sorter = false,
            override_file_sorter = true,
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

return M
