local cmp = require("cmp")
local lspkind = require'lspkind'
local M = {}

M.setup = function()
  lspkind.init()
  cmp.setup({
    sources = {
      { name = "nvim_lua" },
      { name = "nvim_lsp" },
      { name = "vsnip" },
      { name = "path", max_item_count = 100 },
      { name = "buffer", keyword_length = 3 },
    },
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- Comes from vsnip
      end,
    },
    formatting = {
      format = lspkind.cmp_format {
        with_text = true,
        menu = {
          path = "[path]",
          vsnip = "[snip]",
          buffer = "[buf]",
          nvim_lsp = "[LSP]",
          nvim_lua = "[api]",
        },
      },
    },
    mapping = {
      -- None of this made sense to me when first looking into this since there
      -- is no vim docs, but you can't have select = true here _unless_ you are
      -- also using the snippet stuff. So keep in mind that if you remove
      -- snippets you need to remove this select
      ["<CR>"] = cmp.mapping.confirm({ select = true }),
      ['<c-d>'] = cmp.mapping.scroll_docs(-4),
      ['<c-f>'] = cmp.mapping.scroll_docs(4),
      ['<c-q>'] = cmp.mapping.close(),
      ['<c-space>'] = cmp.mapping.complete(),
    },
  })
end

return M
