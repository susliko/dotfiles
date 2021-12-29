local toggleterm_ok, toggleterm = pcall(require, 'toggleterm')
if not toggleterm_ok then return end

local keymap = vim.api.nvim_set_keymap
local buf_keymap = vim.api.nvim_buf_set_keymap

toggleterm.setup{
  -- size can be a number or function which is passed the current terminal
  size = 20,
  open_mapping = [[<c-T>]],
  hide_numbers = true, -- hide the number column in toggleterm buffers
  shade_filetypes = {},
  shade_terminals = false,
  shading_factor = '<number>', -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
  start_in_insert = false,
  insert_mappings = true, -- whether or not the open mapping applies in insert mode
  persist_size = true,
  direction = 'horizontal',
  close_on_exit = true, -- close the terminal window when the process exits
  shell = vim.o.shell, -- change the default shell
}

function _G.toggle_all_terminals()
  local ui = require("toggleterm.ui")
  if not ui.find_open_windows() then
    require("toggleterm").toggle_all('open')
  else
    require("toggleterm").toggle_all('close')
  end
end


function _G.set_terminal_keymaps()
  local opts = {noremap = true}
  buf_keymap(0, 't', '<C-h>', [[<C-\><C-n><C-W>h]], opts)
  buf_keymap(0, 't', '<C-j>', [[<C-\><C-n><C-W>j]], opts)
  buf_keymap(0, 't', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
  buf_keymap(0, 't', '<C-l>', [[<C-\><C-n><C-W>l]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

-- toggling
keymap('n', [[<leader-\>]], ':lua toggle_all_terminals()<CR>', {noremap = true})

local Terminal  = require('toggleterm.terminal').Terminal
-- lazygit
local lazygit = Terminal:new({
  hidden= true,
  cmd = "lazygit",
  dir = "git_dir",
  direction = "float",
  float_opts = {
    border = "curved",
  },
  -- function to run on opening the terminal
  on_open = function(term)
    vim.cmd("startinsert!")
    buf_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
  end,
  close_on_exit = true
})

function _LAZYGIT_TOGGLE()
  lazygit:toggle()
end

-- spotify (flixin' and vibin')
local spotify = Terminal:new({
  hidden = true,
  cmd = "spt",
  dir = "git_dir",
  direction = "float",
  float_opts = {
    border = "curved",
  },
  -- function to run on opening the terminal
  on_open = function(term)
    vim.cmd("startinsert!")
    buf_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
  end,
  close_on_exit = true
})

function _SPOTIFY_TOGGLE()
  spotify:toggle()
end

keymap("n", "<leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", {noremap = true, silent = true})
keymap("n", "<leader>sp", "<cmd>lua _SPOTIFY_TOGGLE()<CR>", {noremap = true, silent = true})
