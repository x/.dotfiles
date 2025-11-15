""" --- Basic Settings ---

set nocompatible      " required
" filetype off        " REMOVED: Only needed for Vundle
syntax enable         " syntax highlighting on
set clipboard=unnamed " use system clipboard (use 'unnamedplus' for Linux)
set hlsearch          " turn on search highlighting
set laststatus=2      " always show status bar
set number            " show line numbers


""" --- Keybindings ---

imap jj <Esc>
nnoremap <c-j> 5<c-e>
nnoremap <c-k> 5<c-y>
set pastetoggle=<F2>

" Fzf configuration
nnoremap <C-p> :Files<CR>
let g:fzf_layout = { 'window': 'enew' }


""" --- Indent Rules ---

" General defaults
set tabstop=4
set shiftwidth=4
set autoindent
set expandtab         " converts tabs to spaces (usually recommended)

" Filetype-specific overrides
augroup FileTypeOverrides
    autocmd!
    autocmd FileType python     setl ts=4 sts=4 sw=4 tw=100 et
    autocmd FileType sql        setl ts=2 sts=2 sw=2 et
    autocmd FileType sh         setl ts=2 sts=2 sw=2 et
    autocmd FileType javascript setl ts=2 sts=2 sw=2 et
    autocmd FileType markdown   setl wrap linebreak
    autocmd FileType tf         setl ts=2 sts=2 sw=2 et
augroup END

" Enable filetype detection, plugins, and indentation rules
filetype plugin indent on

" Theme
colorscheme dracula

" Force transparent background
highlight Normal ctermbg=NONE guibg=NONE
highlight NonText ctermbg=NONE guibg=NONE
