" Bare minimum vimrc, use neovim.

""" --- Basic Settings ---

set nocompatible      " required
filetype off          " required
syntax on             " syntax highlighting on
set clipboard=unnamed " use system clipboard
set hlsearch          " turn on search highlighting
set laststatus=2      " turn on status bar
set number            " show line numbers


""" --- Keybindings ---

imap jj <Esc>
nnoremap <c-j> 5<c-e>
nnoremap <c-k> 5<c-y>
set pastetoggle=<F2>

" Fzf
nnoremap <C-p> :Files<CR>
let g:fzf_layout = { 'window': 'enew' }


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
