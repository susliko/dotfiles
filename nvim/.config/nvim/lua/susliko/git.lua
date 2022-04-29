local gitsigns_ok, gitsigns = pcall(require, "gitsigns")
if not gitsigns_ok then
	return
end

gitsigns.setup({
	signs = {
		add = { hl = "GitSignsAdd", text = "│", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
		change = { hl = "GitSignsChange", text = "│", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
		delete = { hl = "GitSignsDelete", text = "_", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
		topdelete = { hl = "GitSignsDelete", text = "‾", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
		changedelete = { hl = "GitSignsChange", text = "~", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
	},
	signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
	numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
	linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
	word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
	watch_gitdir = {
		interval = 1000,
		follow_files = true,
	},
	attach_to_untracked = true,
	current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
	current_line_blame_opts = {
		virt_text = true,
		virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
		delay = 1000,
		ignore_whitespace = false,
	},
	current_line_blame_formatter_opts = {
		relative_time = false,
	},
	sign_priority = 6,
	update_debounce = 100,
	status_formatter = nil, -- Use default
	max_file_length = 40000,
	preview_config = {
		-- Options passed to nvim_open_win
		border = "single",
		style = "minimal",
		relative = "cursor",
		row = 0,
		col = 1,
	},
	yadm = {
		enable = false,
	},
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', ']c', function()
      if vim.wo.diff then return ']c' end
      vim.schedule(function() gs.next_hunk() end)
      return '<Ignore>'
    end, {expr=true})

    map('n', '[c', function()
      if vim.wo.diff then return '[c' end
      vim.schedule(function() gs.prev_hunk() end)
      return '<Ignore>'
    end, {expr=true})

    -- Actions
    map({'n', 'v'}, '<leader>hs', ':Gitsigns stage_hunk<CR>')
    map({'n', 'v'}, '<leader>hr', ':Gitsigns reset_hunk<CR>')
    map('n', '<leader>hS', gs.stage_buffer)
    map('n', '<leader>hu', gs.undo_stage_hunk)
    map('n', '<leader>hR', gs.reset_buffer)
    map('n', '<leader>hp', gs.preview_hunk)
    map('n', '<leader>hb', function() gs.blame_line{full=true} end)
    map('n', '<leader>tb', gs.toggle_current_line_blame)
    map('n', '<leader>hd', gs.diffthis)
    map('n', '<leader>hD', function() gs.diffthis('~') end)
    map('n', '<leader>td', gs.toggle_deleted)

    -- Text object
    map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
  end
})


local gitlinker_ok, gitlinker = pcall(require, "gitlinker")
if not gitlinker_ok then
	return
end

gitlinker.setup({
  opts = {
    remote = nil, -- force the use of a specific remote
    -- adds current line nr in the url for normal mode
    add_current_line_on_normal_mode = true,
    -- callback for what to do with the url
    action_callback = require"gitlinker.actions".copy_to_clipboard,
    -- print the url after performing the action
    print_url = true,
  },
  callbacks = {
        ["github.com"] = require"gitlinker.hosts".get_github_type_url,
        ["gitlab.com"] = require"gitlinker.hosts".get_gitlab_type_url,
        ["try.gitea.io"] = require"gitlinker.hosts".get_gitea_type_url,
        ["codeberg.org"] = require"gitlinker.hosts".get_gitea_type_url,
        ["bitbucket.org"] = require"gitlinker.hosts".get_bitbucket_type_url,
        ["try.gogs.io"] = require"gitlinker.hosts".get_gogs_type_url,
        ["git.sr.ht"] = require"gitlinker.hosts".get_srht_type_url,
        ["git.launchpad.net"] = require"gitlinker.hosts".get_launchpad_type_url,
        ["repo.or.cz"] = require"gitlinker.hosts".get_repoorcz_type_url,
        ["git.kernel.org"] = require"gitlinker.hosts".get_cgit_type_url,
        ["git.savannah.gnu.org"] = require"gitlinker.hosts".get_cgit_type_url,
        ["gitlab.tcsbank.ru"] = require"gitlinker.hosts".get_gitlab_type_url,
  },
-- default mapping to call url generation with action_callback
  mappings = "<leader>gy"
})
