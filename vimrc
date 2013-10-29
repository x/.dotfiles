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
Bundle 'ervandew/supertab.git'
Bundle 'airblade/vim-gitgutter.git'
Bundle 'ingydotnet/yaml-vim.git'
Bundle 'scrooloose/nerdtree.git'
Bundle 'hynek/vim-python-pep8-indent.git'
Bundle 'tpope/vim-fugitive.git'

filetype plugin indent on

" set 256 colors
set t_Co=256

" turn on syntax highlighting
syntax on

" turn on search highlighting
set hlsearch

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

"highlight current line
set cursorline "cursorcolumn

" super fast up and down movement
nnoremap <c-j> 5<c-e>
nnoremap <c-k> 5<c-y>

" configure NerdTree
map <C-n> :NERDTreeToggle<CR>
let g:NERDTreeWinSize = 40
let NERDTreeChDirMode=2

" shortcut to toggle git gutter
inoremap <c-s> <Esc>:GitGutterToggle<CR>

" highlight anything over 80 columns wide
fun! HighlightOver()
 	highlight OverLength ctermbg=red ctermfg=white guibg=#592929
	match OverLength /\%81v.\+/
endfun

" fuck trailing whitespace function
fun! FuckTrailingWhitespace()
	autocmd BufWritePre <buffer> :%s/\s\+$//e
endfun

" set C preferences (chartbeat does spaces?)
autocmd FileType c
	\ set expandtab |
	\ set softtabstop=4 |
	\ call HighlightOver() |
	\ call FuckTrailingWhitespace()

" set C++ preferences (chartbeat does spaces?)
autocmd FileType c++
	\ set expandtab |
	\ set softtabstop=4 |
	\ call HighlightOver() |
	\ call FuckTrailingWhitespace()

" set ruby preferences
autocmd FileType ruby
	\ set expandtab |
	\ set shiftwidth=2 |
	\ set softtabstop=2 |
	\ call HighlightOver() |
	\ call FuckTrailingWhitespace()

" set html preferences
autocmd FileType html 
	\ set shiftwidth=2 |
	\ set tabstop=2 |
	\ call FuckTrailingWhitespace()

" set html preferences
autocmd FileType jade
	\ set expandtab |
	\ set shiftwidth=2 |
	\ set softtabstop=2 |
	\ call FuckTrailingWhitespace() 

" set coffee preferences
autocmd FileType coffee
	\ set expandtab |
	\ set shiftwidth=2 |
	\ set softtabstop=2 |
    \ hi link coffeeSpaceError NONE
	\ call HighlightOver() |
	\ call FuckTrailingWhitespace()

" set javascript preferences
autocmd FileType javascript
	\ set expandtab |
	\ set shiftwidth=2 |
	\ set softtabstop=2 |
	"\ call HighlightOver() |
	\ call FuckTrailingWhitespace()

" set python preferences
autocmd FileType python
	\ set shiftwidth=4 |
	\ set softtabstop=4 |
    \ set smarttab |
	\ set expandtab |
	\ call HighlightOver() |
	\ call FuckTrailingWhitespace() |
    \ let g:syntastic_python_checkers = ['pyflakes']

" set puppet preferences
autocmd FileType puppet
	\ set expandtab |
	\ set shiftwidth=2 |
	\ set softtabstop=2 |
	\ call HighlightOver() |
	\ call FuckTrailingWhitespace()

" set yaml preferences
autocmd FileType yaml
	\ set expandtab |
	\ set shiftwidth=2 |
	\ set softtabstop=2 |
	\ call FuckTrailingWhitespace()
