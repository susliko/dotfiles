local orgmode_ok, orgmode = pcall(require, "orgmode")
if not orgmode_ok then
  return
end

-- Load custom tree-sitter grammar for org filetype
orgmode.setup_ts_grammar()
orgmode.setup({
  org_agenda_files = { '~/diary/*' },
  org_default_notes_file = '~/diary/default.org',
})


local ts_configs_ok, ts_configs = pcall(require, "nvim-treesitter.configs")
if not ts_configs_ok then
  return
end

-- Tree-sitter configuration
ts_configs.setup { -- If TS highlights are not enabled at all, or disabled via `disable` prop, highlighting will fallback to default Vim syntax highlighting
  highlight = {
    enable = true,
    disable = { 'org' }, -- Remove this to use TS highlighter for some of the highlights (Experimental)
    additional_vim_regex_highlighting = { 'org' }, -- Required since TS highlighter doesn't support all syntax features (conceal)
  },
  ensure_installed = { 'org' }, -- Or run :TSUpdate org
}
