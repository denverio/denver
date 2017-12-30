" set custom path
let g:vimCustomPath = '/app'

" set vim-plug home
let g:plug_home = '/app/plugged'

try
  " load .vimrc if exists
  source /app/.vimrc
catch
  " ignoring
endtry
