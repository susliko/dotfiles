return {
  on_attach = function(client, bufnr)
    require("susliko.lang.lsp.handlers").on_attach(client, bufnr)
    require("susliko.lang.lsp.handlers").create_format_autocmds(client, bufnr)
  end,
	settings = {
		haskell = {
      formattingProvider = "stylish-haskell"
		},
	},
}
