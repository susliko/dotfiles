vim.cmd [[
  augroup _general_settings
    autocmd!
    autocmd FileType qf,help,man,lspinfo nnoremap <silent> <buffer> q :close<CR> 
    autocmd TextYankPost * silent!lua require('vim.highlight').on_yank({higroup = 'Search', timeout = 200}) 
    autocmd BufWinEnter * :set formatoptions-=cro
    autocmd FileType qf set nobuflisted
  augroup end
  augroup _markdown
    autocmd!
    autocmd FileType markdown setlocal wrap
    autocmd FileType markdown setlocal spell
  augroup end
  augroup _autoread
    autocmd!
    autocmd FocusGained,BufEnter,CursorHold,CursorHoldI *.tla if mode() != 'c' | checktime | endif
  augroup end
  augroup _tex
    autocmd!
    autocmd FileType tex set keymap=russian-jcukenwin
    autocmd FileType tex set iminsert=0
    autocmd FileType tex set imsearch=-1
  augroup end
]]
