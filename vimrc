" fix vim compatability
set nocompatible

" enable pathogen plugins
runtime bundle/pathogen/autoload/pathogen.vim
call pathogen#infect()
filetype plugin indent on

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

" keep powerline on
set laststatus=2

" colors
colorscheme ron

" map jj to normal mode
imap jj <Esc>

" turn on syntax highlighting
syntax on

" turn off whitespace highlighting with the coffeescript plugin
hi link coffeeSpaceError NONE

" highlight anything over 80 columns wide
fun! HighlightOver()
	highlight OverLength ctermbg=darkred ctermfg=white guibg=#FFD9D9
	match OverLength /\%81v.\+/
endfun

" set ruby preferences
autocmd FileType ruby
	\ set expandtab |
	\ set shiftwidth=2 |
	\ set softtabstop=2 |
	\ call HighlightOver()

" set html tabs
autocmd FileType html 
	\ set shiftwidth=2 |
	\ set softtabstop=2 |
	\ tabstop=2

" set coffee tabs
autocmd FileType coffeescript
	\ set expandtab |
	\ set shiftwidth=2 |
	\ set softtabstop=2 |
	\ call HighlightOver()
