" vestigial
set nocompatible

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

" fancy status bar
Bundle 'Lokaltog/vim-powerline.git'
set laststatus=2

" fuzzy search
Bundle 'kien/ctrlp.vim.git'
let ctrlp_filter_greps = "".
    \ "egrep -iv '\\.(" .
    \ "jar|class|swp|swo|log|so|o|pyc|jpe?g|png|gif|mo|po" .
    \ ")$' | " .
    \ "egrep -v '^(\\./)?(" .
    \ "vendor/|lib/|classes/|libs/|deploy/|.git/|.hg/|.svn/|.*migrations/" .
    \ ")'"
let my_ctrlp_git_command = "" .
    \ "cd %s && git ls-files | " .
    \ ctrlp_filter_greps
if has("unix")
    let my_ctrlp_user_command = "" .
    \ "find %s '(' -type f -or -type l ')' -maxdepth 15 -not -path '*/\\.*/*' | " .
    \ ctrlp_filter_greps
endif
let g:ctrlp_user_command = ['.git/', my_ctrlp_git_command, my_ctrlp_user_command]

" needed for legacy
Bundle 'tpope/vim-pathogen.git'

" Git
Bundle 'tpope/vim-fugitive.git'
Bundle 'airblade/vim-gitgutter.git'

" syntax
Bundle 'kchmck/vim-coffee-script.git'
Bundle 'rodjek/vim-puppet.git'
Bundle 'vim-scripts/python.vim.git'
Bundle 'guns/vim-clojure-static.git'
syntax on

" clojure life
Bundle 'amdt/vim-niji.git'
Bundle 'tpope/vim-leiningen.git'
Bundle 'tpope/vim-fireplace.git'

" checking syntax errors
Bundle 'scrooloose/syntastic.git'

" nice python indenting
Bundle 'hynek/vim-python-pep8-indent.git'

filetype plugin indent on

" map jj to normal mode
imap jj <Esc>

" map f2 to toggle past mode
set pastetoggle=<F2>

" super fast up and down movement
nnoremap <c-j> 5<c-e>
nnoremap <c-k> 5<c-y>

" set 256 colors
set t_Co=256

" colors
colorscheme jellybeans

" clean up itgutter
highlight clear SignColumn

" turn on search highlighting
set hlsearch

" show line numbers
set number

" mark the 81st column
set colorcolumn=81

" Unset undesirable rules
set nocindent
set nosmartindent

" Normal indentation rules
set tabstop=4
set shiftwidth=4
set autoindent

" fuck trailing whitespace function
fun! FuckTrailingWhitespace()
	autocmd BufWritePre <buffer> :%s/\s\+$//e
endfun

" set C preferences (chartbeat does spaces?)
autocmd FileType c
			\ set expandtab |
			\ set softtabstop=4 |
			\ call FuckTrailingWhitespace()

" set C++ preferences (chartbeat does spaces?)
autocmd FileType cpp
			\ set expandtab |
			\ set softtabstop=4 |
			\ call FuckTrailingWhitespace()

" set ruby preferences
autocmd FileType ruby
			\ set expandtab |
			\ set shiftwidth=2 |
			\ set softtabstop=2 |
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
			\ call FuckTrailingWhitespace() |
			\ hi link coffeeSpaceError NONE

" set javascript preferences
autocmd FileType javascript
			\ set expandtab |
			\ set shiftwidth=2 |
			\ set softtabstop=2 |
			\ call FuckTrailingWhitespace() |
			\ let g:syntastic_javascript_checkers=['']

" set python preferences
autocmd FileType python
			\ set shiftwidth=4 |
			\ set softtabstop=4 |
			\ set smarttab |
			\ set expandtab |
			\ call FuckTrailingWhitespace() |
			\ let g:syntastic_python_checkers = ['pyflakes']

" set clojure preferences
autocmd FileType clojure
			\ call FuckTrailingWhitespace()

" set puppet preferences
autocmd FileType puppet
			\ set expandtab |
			\ set shiftwidth=2 |
			\ set softtabstop=2 |
			\ call FuckTrailingWhitespace()

" set yaml preferences
autocmd FileType yaml
			\ set expandtab |
			\ set shiftwidth=2 |
			\ set softtabstop=2 |
			\ call FuckTrailingWhitespace()
