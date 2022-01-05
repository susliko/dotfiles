local options = {
  backup = false,
  clipboard = "unnamedplus",
  cmdheight = 1,
  completeopt = { "menuone", "noselect", "noinsert" }, -- mostly just for cmp
  conceallevel = 0,                        -- so that `` is visible in markdown files
  fileencoding = "utf-8",
  hlsearch = true,
  ignorecase = true,
  keymap = "russian-jcukenwin",
  pumheight = 10,                          -- pop up menu height
  showmode = false,                        -- we don't need to see things like -- INSERT -- anymore
  smartcase = true,
  smartindent = true,
  splitbelow = true,
  splitright = true,
  swapfile = false,
  termguicolors = true,
  undofile = true,
  updatetime = 300,                        -- faster completion (4000ms default)
  writebackup = false,                     -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
  expandtab = true,
  shiftwidth = 2,
  tabstop = 2,
  number = true,
  relativenumber = true,
  numberwidth = 4,                         -- set number column width to 2 {default 4}
  signcolumn = "yes",                      -- always show the sign column, otherwise it would shift the text each time
  wrap = true,
  scrolloff = 8,
  guifont = "monospace:h17",               -- the font used in graphical neovim applications
}

vim.opt.shortmess:append("c"):remove("F")

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.cmd "set whichwrap+=<,>,[,],h,l"
vim.cmd [[set iskeyword+=-]]
