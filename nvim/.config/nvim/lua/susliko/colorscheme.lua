vim.cmd [[
try
  let g:gruvbox_guisp_fallback = "bg"
  colorscheme gruvbox
  set background=dark    
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry
]]
