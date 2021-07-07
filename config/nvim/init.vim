" -- Ensure that VimPlug is installed --
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()

" Fzf for fuzzy-finding files
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Nicer looking status bar
Plug 'vim-airline/vim-airline'

" Themes
Plug 'rakr/vim-one'
Plug 'nanotech/jellybeans.vim'
Plug 'endel/vim-github-colorscheme'
Plug 'crusoexia/vim-dracula'

" Wiki
Plug 'vimwiki/vimwiki'

" Python
Plug 'vim-python/python-syntax'
Plug 'psf/black'
Plug 'fisadev/vim-isort'

" Git
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'airblade/vim-gitgutter'

" Syntax checking
Plug 'vim-syntastic/syntastic'

" Ctags
" Need to run: brew install --HEAD universal-ctags/universal-ctags/universal-ctags
Plug 'ludovicchabant/vim-gutentags'

" Toml Syntax
Plug 'cespare/vim-toml'

call plug#end()

" Wildcard ignore
set wildignore+=*.o,*~,*.pyc,*.mypy_cache

" Give fzf ctrl-p behavior
nnoremap <C-p> :<C-u>FZF<CR>

" !pyenv virtualenv 3.9.4 neovim
let g:python3_host_prog = $HOME . '/.pyenv/versions/neovim/bin/python'

" Black settings
let g:black_linelength = 100
let g:black_fast = 1
let g:black_quiet = 1

" ISort settings
let g:vim_isort_config_overrides = {'ensure_newline_before_comments': 1, 'force_grid_wrap': 0, 'include_trailing_comma': 1, 'line_length': 100, 'multi_line_output': 3, 'use_parentheses': 1}

" Syntastic settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 0
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_aggregate_errors = 1

let g:syntastic_python_checkers = ['flake8', 'mypy']

" Vimwiki settings
let g:vimwiki_list = [{'path': '~/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]

" Gutentags settings - I don't understand these...
" See: https://github.com/ludovicchabant/vim-gutentags/issues/178#issuecomment-575693926
let g:gutentags_project_root  = ['package.json', '.git', '.hg', '.svn']
let g:gutentags_cache_dir = expand('~/.gutentags_cache')
let g:gutentags_exclude_filetypes = ['gitcommit', 'gitconfig', 'gitrebase', 'gitsendemail', 'git']
let g:gutentags_generate_on_new = 1
let g:gutentags_generate_on_missing = 1
let g:gutentags_generate_on_write = 1
let g:gutentags_generate_on_empty_buffer = 0
let g:gutentags_ctags_extra_args = ['--tag-relative=yes','--fields=+ailmnS']
let g:gutentags_ctags_exclude = [
\  '*.git', '*.svn', '*.hg',
\  'cache', 'build', 'dist', 'bin', 'node_modules', 'bower_components',
\  '*-lock.json',  '*.lock',
\  '*.min.*',
\  '*.bak',
\  '*.zip',
\  '*.pyc',
\  '*.class',
\  '*.sln',
\  '*.csproj', '*.csproj.user',
\  '*.tmp',
\  '*.cache',
\  '*.vscode',
\  '*.pdb',
\  '*.exe', '*.dll', '*.bin',
\  '*.mp3', '*.ogg', '*.flac',
\  '*.swp', '*.swo',
\  '.DS_Store', '*.plist',
\  '*.bmp', '*.gif', '*.ico', '*.jpg', '*.png', '*.svg',
\  '*.rar', '*.zip', '*.tar', '*.tar.gz', '*.tar.xz', '*.tar.bz2',
\  '*.pdf', '*.doc', '*.docx', '*.ppt', '*.pptx', '*.xls',
\]

" Configure python syntax highlighting
let g:python_highlight_all = 1

" Color Theme
if system("defaults read -g AppleInterfaceStyle") =~ '^Dark'
  colorscheme dracula
else
  colorscheme one
  set background=light
endif

" Powerline Theme
let g:airline_theme='one'
let g:airline_powerline_fonts = 1

" Enable italics coments
let &t_ZH="\e[3m"
let &t_ZR="\e[23m"
highlight Comment cterm=italic gui=italic
let g:dracula_italic = 1

" Use system clipboard
set clipboard+=unnamedplus

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

" Override default language settings
au FileType sql setl ts=2 sts=0 sw=2 et
au FileType sh setl ts=2 sw=2 ts=2 et
au FileType javascript setl ts=2 sw=2 ts=2 et
au FileType vimwiki set wrap linebreak spell
au FileType python set cc=101

" Run black, isort, and flake8 on python files
au BufWritePost *.py execute ':Black'
au BufWritePost *.py execute ':Isort'

" Remove all trailing whitespace
au BufWritePre <buffer> :%s/\s\+$//e

" turn on plugin indentation
filetype plugin indent on

" Use underlines for set spell
hi clear SpellBad
hi SpellBad cterm=underline
