" set custom path
let g:vimCustomPath = '/denver/.config/vim'

" set vim-plug home
let g:plug_home = '/denver/.config/vim/plugged'

try
  " load .vimrc if exists
  source /denver/.config/vim/.vimrc
catch
  " ignoring
endtry
