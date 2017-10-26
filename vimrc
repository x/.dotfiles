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

" Autoformat
Plugin 'google/vim-maktaba'
Plugin 'google/vim-codefmt'
Plugin 'google/vim-glaive'


" end vundle plugin list
call vundle#end()


"" --- Plugin Settings ---

" Google Java Formatting
call glaive#Install()

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

" turn on status bar
set laststatus=2

" show line numbers
set number

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

" Set language specific settings
au FileType python setl sw=4 sts=4 et cc=81
au FileType java set sw=2 sts=2 noai et tw=100 cc=101

" Auto-format settings. See: https://github.com/google/vim-codefmt for more
augroup autoformat_settings
  autocmd FileType java AutoFormatBuffer google-java-format
  "autocmd FileType python AutoFormatBuffer autopep8
  autocmd FileType python AutoFormatBuffer yapf
augroup END

" turn on plugin indentation
filetype plugin indent on
