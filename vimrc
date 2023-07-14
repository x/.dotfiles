"" --- Plugins (managed by Vundle) ---

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'       " Let vundle manage itself
Plugin 'vim-airline/vim-airline' " Decoration
Plugin 'ctrlpvim/ctrlp.vim'      " Fuzzy search
Plugin 'tpope/vim-fugitive'      " Standard git commands
Plugin 'tpope/vim-rhubarb'       " Just the gbrowse command
Plugin 'airblade/vim-gitgutter'  " See diffs

Plugin 'rakr/vim-one'            " Theme
Plugin 'crusoexia/vim-dracula'   " Theme

Plugin 'vim-scripts/python.vim'  " Python
Plugin 'guns/vim-clojure-static' " Clojure
Plugin 'fatih/vim-go'            " Go
Plugin 'stephpy/vim-yaml'        " Yaml
Plugin 'cespare/vim-toml'        " Toml
Plugin 'jparise/vim-graphql'     " GraphQL
Plugin 'hashivim/vim-terraform'  " Terraform

Plugin 'dense-analysis/ale'      " Linter and formatter

call vundle#end()


"" --- Basic Settings ---

set nocompatible      " required
filetype off          " required
syntax on             " syntax highlighting on
set clipboard=unnamed " use system clipboard
set hlsearch          " turn on search highlighting
set laststatus=2      " turn on status bar
set number            " show line numbers


"" --- Keybindings ---

imap jj <Esc>
nnoremap <c-j> 5<c-e>
nnoremap <c-k> 5<c-y>
set pastetoggle=<F2>


"" --- Theme ---

" Hack to fix the git-gutter background behavior
autocmd ColorScheme * highlight! link SignColumn LineNr

set t_Co=256
set background=dark
colorscheme dracula
let g:airline_theme='one'
hi Normal guibg=NONE ctermbg=NONE

" Enable italics for comments
let &t_ZH="\e[3m"
let &t_ZR="\e[23m"
highlight Comment cterm=italic gui=italic
let g:dracula_italic = 3

" Plugin Theme Settings
highlight clear SignColumn        " Setup gitgutter
let g:airline_powerline_fonts = 1 " Fancy powerline fonts


""" --- Indent Rules ---

set nocindent
set nosmartindent
set tabstop=4
set shiftwidth=4
set autoindent

au FileType py setl ts=4 sts=4 sw=4 tw=100 et
au FileType sql setl ts=2 sts=0 sw=2 et
au FileType sh setl ts=2 sw=2 ts=2 et
au FileType javascript setl ts=2 sw=2 ts=2 et
au FileType markdown set wrap linebreak
au FileType tf setl ts=2 sts=0 sw=2 et

" Allow plugins to override
filetype plugin indent on


"" --- Language Server Settings ---

let g:ale_fix_on_save = 1         " Run fixers on save
let g:ale_python_auto_poetry = 1  " Enable poetry for python


let g:ale_linters = {
\	"python": ["ruff", "mypy"],
\	"bash": ["shellcheck"],
\	"terraform": ["terraform", "tflint"]
\}
let g:ale_fixers = {
\	"*": ["remove_trailing_lines"],
\	"python": ["black", "ruff"],
\	"bash": ["shfmt"]
\}


"" --- Ctrl-P Settings ---

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
