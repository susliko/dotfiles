local actions = require("telescope.actions")
local transform_mod = require('telescope.actions.mt').transform_mod

local custom_actions = transform_mod({
  toggle_hidden = function(prompt_bufnr)
    picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
    picker:refresh(require("telescope.finders").JobFinder:new({}), {}) -- TODO
  end,
})

local trim_path_vowels = function(opts, path)
  local sep = require("telescope.utils").get_separator()
  local filename = require("telescope.utils").path_tail(path)
  local filepath = string.gsub(path, sep .. filename, "")
  if  (filepath == filename) then
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

        file_previewer = require("telescope.previewers").vim_buffer_cat.new,
        grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
        qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
				
				layout_config = {
					vertical = { width = 0.5 } -- TODO
				},

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

M.lsp_workspace_symbols = function()
  local input = vim.fn.input("Query: ")
  vim.api.nvim_command("normal :esc<CR>")
  if not input or #input == 0 then
    return
  end
  require("telescope.builtin").lsp_workspace_symbols({ query = input })
end

return M
