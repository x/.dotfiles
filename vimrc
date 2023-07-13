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
Plugin 'tpope/vim-rhubarb'
Plugin 'airblade/vim-gitgutter'

" language specific
Plugin 'vim-scripts/python.vim'
Plugin 'guns/vim-clojure-static'
Plugin 'vim-scripts/vim-niji'
Plugin 'fatih/vim-go'
Plugin 'stephpy/vim-yaml'
Plugin 'cespare/vim-toml'
Plugin 'jparise/vim-graphql'

" indentation
Plugin 'hynek/vim-python-pep8-indent'

" color
Plugin 'rakr/vim-one'
Plugin 'nanotech/jellybeans.vim'
Plugin 'endel/vim-github-colorscheme'
Plugin 'crusoexia/vim-dracula'

" Autoformat
Plugin 'google/vim-maktaba'
Plugin 'google/vim-codefmt'
Plugin 'google/vim-glaive'
Plugin 'psf/black'
"Plugin 'fisadev/vim-isort'

" Wiki
Plugin 'vimwiki/vimwiki'

" Tmux
Plugin 'edkolev/tmuxline.vim'
let g:tmuxline_preset = 'nightly_fox'

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

" Vimwiki settings
let g:vimwiki_list = [{'path': '~/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]

"" --- Basic Settings ---

" vestigial
set nocompatible

" use system clipboard
set clipboard=unnamed

" syntax highlighting on
syntax on

" Workaround for GitGutter to match colorscheme (BEFORE)
autocmd ColorScheme * highlight! link SignColumn LineNr

" colorscheme
set t_Co=256
set background=dark
colorscheme dracula
let g:airline_theme='one'

" Don't use the color scheme's bg color
hi Normal guibg=NONE ctermbg=NONE

" Enable italics coments
let &t_ZH="\e[3m"
let &t_ZR="\e[23m"
highlight Comment cterm=italic gui=italic
let g:dracula_italic = 3

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

" Override default tab settings
au FileType sql setl ts=2 sts=0 sw=2 et
au FileType sh setl ts=2 sw=2 ts=2 et
au FileType javascript setl ts=2 sw=2 ts=2 et
au FileType markdown set wrap linebreak
au FileType tf setl ts=2 sts=0 sw=2 et

" Remove all trailing whitespace
autocmd BufWritePre <buffer> :%s/\s\+$//e

" Python formatting settings
"autocmd BufWritePost *.py silent! execute ':Black'

" turn on plugin indentation
filetype plugin indent on
