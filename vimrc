"" --- Plugins (managed by Vundle) ---

" start vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" vundle managest itself
Plugin 'gmarik/Vundle.vim'

" decoration
Plugin 'Lokaltog/vim-powerline.git'
Plugin 'kien/ctrlp.vim.git'

" git
Plugin 'tpope/vim-fugitive.git'
Plugin 'airblade/vim-gitgutter.git'

" syntax highlighting
Plugin 'vim-scripts/python.vim.git'
Plugin 'guns/vim-clojure-static.git'
Plugin 'vim-scripts/vim-niji.git'
Plugin 'rodjek/vim-puppet.git'

"indentation
Plugin 'hynek/vim-python-pep8-indent.git'

" syntax checking
Plugin 'scrooloose/syntastic.git'

" end vundle plugin list
call vundle#end()


"" --- Plugin Settings ---

" gitgutter settings
highlight clear SignColumn

" ctrl+p settings
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


"" --- Basic Settings ---

" vestigial
set nocompatible

" colors
set t_Co=256
colorscheme jellybeans

" turn on syntax highlighting
syntax on

" turn on search highlighting
set hlsearch

" turn on plugin indentation
filetype plugin indent on

" turn on status bar
set laststatus=2

" show line numbers
set number

" mark the 81st column
set colorcolumn=81

" shorthand
imap jj <Esc>
nnoremap <c-j> 5<c-e>
nnoremap <c-k> 5<c-y>
set pastetoggle=<F2>

" Set default indentation rules
set nocindent
set nosmartindent
set tabstop=4
set shiftwidth=4
set autoindent


"" --- Custom functions ---

fun! FuckTrailingWhitespace()
	autocmd BufWritePre <buffer> :%s/\s\+$//e
endfun


"" --- Language Specific Settings ---

autocmd FileType c
			\ set expandtab |
			\ set softtabstop=4 |
			\ call FuckTrailingWhitespace()

autocmd FileType cpp
			\ set expandtab |
			\ set softtabstop=4 |
			\ call FuckTrailingWhitespace()

autocmd FileType ruby
			\ set expandtab |
			\ set shiftwidth=2 |
			\ set softtabstop=2 |
			\ call FuckTrailingWhitespace()

autocmd FileType html 
			\ set shiftwidth=2 |
			\ set tabstop=2 |
			\ call FuckTrailingWhitespace()

autocmd FileType jade
			\ set expandtab |
			\ set shiftwidth=2 |
			\ set softtabstop=2 |
			\ call FuckTrailingWhitespace() 

autocmd FileType javascript
			\ set expandtab |
			\ set shiftwidth=2 |
			\ set softtabstop=2 |
			\ call FuckTrailingWhitespace() |
			\ let g:syntastic_javascript_checkers=['']

autocmd FileType python
			\ set shiftwidth=4 |
			\ set softtabstop=4 |
			\ set smarttab |
			\ set expandtab |
			\ call FuckTrailingWhitespace() |
			\ let g:syntastic_python_checkers = ['pyflakes']

autocmd FileType clojure
			\ call FuckTrailingWhitespace()

autocmd FileType puppet
			\ set expandtab |
			\ set shiftwidth=2 |
			\ set softtabstop=2 |
			\ call FuckTrailingWhitespace()

autocmd FileType yaml
			\ set expandtab |
			\ set shiftwidth=2 |
			\ set softtabstop=2 |
			\ call FuckTrailingWhitespace()
