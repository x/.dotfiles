" fix vim compatability
set nocompatible

" support 256 terminal colors
set t_Co=256

" map f2 to toggle past mode
set pastetoggle=<F2>

" Normal indentation rules
set smartindent
set tabstop=4
set shiftwidth=4

" show line numbers
set number

" colors
colorscheme ron

" map jj to normal mode
imap jj <Esc>

" turn on syntax highlighting
syntax on

" enable pathogen plugins
call pathogen#infect()
filetype plugin indent on

" turn off whitespace highlighting with the coffeescript plugin
hi link coffeeSpaceError NONE

" highlight anything over 80 columns wide
highlight OverLength ctermbg=darkred ctermfg=white guibg=#FFD9D9
match OverLength /\%81v.\+/

" set ruby tabs
autocmd FileType ruby set shiftwidth=2
autocmd FileType ruby set softtabstop=2
autocmd FileType ruby set tabstop=2

" set html tabs
autocmd FileType html set shiftwidth=2
autocmd FileType html set softtabstop=2
autocmd FileType html set tabstop=2

" set coffee tabs
autocmd FileType coffee set shiftwidth=2
autocmd FileType coffee set softtabstop=2
autocmd FileType coffee set tabstop=2
