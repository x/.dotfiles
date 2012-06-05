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
set clipboard=unnamed
set mouse=a
set t_Co=256
colorscheme ron
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

syntax on
hi link coffeeSpaceError NONE
" coffeescript magic autocompile
" autocmd BufWritePost *.coffee silent CoffeeMake! -b | cwindow

"Ruby Stuff
autocmd FileType ruby set shiftwidth=2
autocmd FileType ruby set softtabstop=2
autocmd FileType ruby set tabstop=2
"This highlights anything more than 80 collumns
autocmd FileType ruby highlight OverLength ctermbg=darkred ctermfg=white guibg=#FFD9D9
autocmd FileType ruby match OverLength /\%81v.\+/

"html stuff
autocmd FileType html set shiftwidth=2
autocmd FileType html set softtabstop=2
autocmd FileType html set tabstop=2

"coffee stuff
autocmd FileType coffee set shiftwidth=2
autocmd FileType coffee set softtabstop=2
autocmd FileType coffee set tabstop=2

"start pathogen
call pathogen#infect()
syntax on
filetype plugin indent on
