
fun! MySys()
   return "$1"
endfun
"$set runtimepath=~/.vim_runtime,~/.vim_runtime/after,\$VIMRUNTIME
"source ~/.vim_runtime/vimrc
"helptags ~/.vim_runtime/doc
set smartindent
set tabstop=4
set shiftwidth=4
set number
set nocompatible
set pastetoggle=<F2>
colorscheme ron
set mouse=a
imap jj <Esc>

filetype indent on
filetype plugin on
" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'

set t_Co=256

syntax on
hi link coffeeSpaceError NONE
" coffeescript magic autocompile
autocmd BufWritePost *.coffee silent CoffeeMake! -b | cwindow
