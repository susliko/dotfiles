local stylua_ok, _ = pcall(require, "stylua-nvim")
if not stylua_ok then
	return
end

local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

local function lua_format_document()
	vim.cmd([[ 
      command! FormatLua execute 'lua require("stylua-nvim").format_file()' 
    ]])
end

return {
	on_attach = function(client, bufnr)
		require("susliko.lang.lsp.handlers").on_attach(client, bufnr)
		lua_format_document()
	end,
	capabilities = require("susliko.lang.lsp.handlers").capabilities,
	flags = {
		debounce_text_changes = 150,
	},
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
				path = runtime_path,
			},
			diagnostics = {
				globals = { "vim" },
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
