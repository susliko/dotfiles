local ts_ok, configs = pcall(require, "nvim-treesitter.configs")
if not ts_ok then
	return
end

local ts_parsers_ok, parsers = pcall(require, "nvim-treesitter.parsers")
if not ts_parsers_ok then
	return
end

local parser_configs = parsers.get_parser_configs()
parser_configs.org = {
	install_info = {
		url = "https://github.com/milisims/tree-sitter-org",
		revision = "main",
		files = { "src/parser.c", "src/scanner.cc" },
	},
	filetype = "org",
}

parser_configs.tlaplus = {
	install_info = {
		url = "~/programming/public/tree-sitter-tlaplus",
		revision = "pluscal-support",
		files = { "src/parser.c", "src/scanner.cc" },
	},
	filetype = "tla",
}

configs.setup({
	ensure_installed = "all",
	sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
	ignore_install = { "tlaplus" }, -- List of parsers to ignore installing
	autopairs = {
		enable = true,
	},
	highlight = {
		enable = true,
		disable = { "org" }, -- Remove this to use TS highlighter for some of the highlights (Experimental)
		additional_vim_regex_highlighting = true,
	},
})
