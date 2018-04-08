" set custom path
let g:vimCustomPath = $DENVER_CONFIG . '/vim'

" set vim-plug home
let g:plug_home = g:vimCustomPath . '/plugged'

try
  " load .vimrc if exists
  source $DENVER_CONFIG/vim/.vimrc
catch
  " ignoring
endtry
