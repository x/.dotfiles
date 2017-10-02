"" --- Plugins (managed by Vundle) ---

" start vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" vundle managest itself
Plugin 'gmarik/Vundle.vim'

" decoration
Plugin 'vim-airline/vim-airline'
Plugin 'ctrlpvim/ctrlp.vim'

" git
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'

" syntax highlighting
Plugin 'vim-scripts/python.vim'
Plugin 'guns/vim-clojure-static'
Plugin 'vim-scripts/vim-niji'
Plugin 'rodjek/vim-puppet'
Plugin 'kevints/vim-aurora-syntax'

" indentation
Plugin 'hynek/vim-python-pep8-indent'

" syntax checking
Plugin 'scrooloose/syntastic'

" color
Plugin 'rakr/vim-one'
Plugin 'nanotech/jellybeans.vim'
Plugin 'endel/vim-github-colorscheme'

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

" use powerline fonts (install from github.com/powerline/fonts)
let g:airline_powerline_fonts = 1


"" --- Basic Settings ---

" vestigial
set nocompatible

" use system clipboard
set clipboard=unnamed

" syntax highlighting on
syntax on

" colorscheme
set t_Co=256
colorscheme one
set background=light
let g:airline_theme='one'
hi Normal ctermbg=none

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

" things my fingers have memorized
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

" Remove all trailing whitespace
autocmd BufWritePre <buffer> :%s/\s\+$//e
