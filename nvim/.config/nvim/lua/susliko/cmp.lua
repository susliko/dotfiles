local cmp_ok, cmp = pcall(require, 'cmp')
if not cmp_ok then return end
local lspkind_ok, lspkind = pcall(require, 'lspkind')
if not lspkind_ok then return end

-- lsp icons for autocompletion
cmp.setup({
  sources = {
    { name = 'nvim_lua' },
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
    { name = 'path', max_item_count = 100 },
    { name = 'buffer', keyword_length = 3 },
  },
  snippet = {
    expand = function(args)
      vim.fn['vsnip#anonymous'](args.body) -- Comes from vsnip
    end,
  },
  formatting = {
    format = lspkind.cmp_format {
      with_text = true,
      menu = {
        path = '[path]',
        vsnip = '[snip]',
        buffer = '[buf]',
        nvim_lsp = '[lsp]',
        nvim_lua = '[nvim]',
      },
    },
  },
  mapping = {
    -- None of this made sense to me when first looking into this since there
    -- is no vim docs, but you can't have select = true here _unless_ you are
    -- also using the snippet stuff. So keep in mind that if you remove
    -- snippets you need to remove this select
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<c-d>'] = cmp.mapping.scroll_docs(-4),
    ['<c-f>'] = cmp.mapping.scroll_docs(4),
    ['<c-q>'] = cmp.mapping.close(),
    ['<c-space>'] = cmp.mapping.complete(),
  },
})

