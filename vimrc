" fix vim compatability
set nocompatible

" FUCK PATHOGEN, SWITCHING TO VUNDLE
"" enable pathogen plugins
"runtime bundle/pathogen/autoload/pathogen.vim
"call pathogen#infect()

" Vundle magic
"
" Installation:
" 	open vim
" 	run :BundleInstall
"
set rtp+=~/.vim/bundle/vundle
call vundle#rc()

" Let Vundle manage Vundle
Bundle 'gmarik/vundle'

" plugins from Github managed by vundle
Bundle 'vim-ruby/vim-ruby.git'
Bundle 'Lokaltog/vim-powerline.git'
Bundle 'kien/ctrlp.vim.git'
Bundle 'tpope/vim-pathogen.git'
Bundle 'digitaltoad/vim-jade.git'
Bundle 'scrooloose/syntastic.git'
Bundle 'plasticboy/vim-markdown.git'
Bundle 'davidhalter/jedi-vim.git'
Bundle 'rodjek/vim-puppet.git'

filetype plugin indent on

" set 256 colors
set t_Co=256

" turn on syntax highlighting
syntax on

" map f2 to toggle past mode
set pastetoggle=<F2>

" Normal indentation rules
set autoindent
set tabstop=4
set shiftwidth=4

" show line numbers
set number

" keep powerline on
set laststatus=2

" colors
colorscheme jellybeans

" map jj to normal mode
imap jj <Esc>

" change tabs using ctrl+arrow keys
nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>
nnoremap <silent> <A-Left> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
nnoremap <silent> <A-Right> :execute 'silent! tabmove ' . tabpagenr()<CR>

" lightnight fast up and down movement
nnoremap <c-j> 5j
nnoremap <c-k> 5k

" turn off whitespace highlighting with the coffeescript plugin
hi link coffeeSpaceError NONE

" highlight anything over 80 columns wide
fun! HighlightOver()
	highlight OverLength ctermbg=darkred ctermfg=white guibg=#FFD9D9
	match OverLength /\%81v.\+/
endfun

" fuck trailing whitespace
autocmd BufWritePre *.py :%s/\s\+$//e

" set C preferences
autocmd FileType c
	\ call HighlightOver()

" set ruby preferences
autocmd FileType ruby
	\ set expandtab |
	\ set shiftwidth=2 |
	\ set softtabstop=2 |
	\ call HighlightOver()

" set html tabs
autocmd FileType html 
	\ set shiftwidth=2 |
	\ set tabstop=2

" set html tabs
autocmd FileType jade
	\ set expandtab |
	\ set shiftwidth=2 |
	\ set softtabstop=2

" set coffee tabs
autocmd FileType coffee
	\ set expandtab |
	\ set shiftwidth=2 |
	\ set softtabstop=2 |
	\ call HighlightOver()

" set javascript tabs
autocmd FileType javascript
	\ set expandtab |
	\ set shiftwidth=2 |
	\ set softtabstop=2 |
	\ call HighlightOver()

" set python tabs
autocmd FileType python
	\ set expandtab |
	\ set shiftwidth=4 |
	\ set softtabstop=4 |
	\ call HighlightOver()
