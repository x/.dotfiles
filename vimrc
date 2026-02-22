""" --- Basic Settings ---
set nocompatible      " Disable legacy Vi behaviors for modern features
syntax on             " Enable syntax highlighting
filetype plugin indent on " Enable detection, plugins, and indenting for filetypes

set clipboard=unnamed " Use system clipboard (works on macOS/Windows)
if has('unnamedplus') | set clipboard=unnamedplus | endif " Use + register for Linux
set hlsearch          " Highlight all matches of the previous search
set incsearch         " Show where the search pattern matches while typing
set ignorecase        " Ignore case in search patterns
set smartcase         " Override ignorecase if search contains capitals
set laststatus=2      " Always show the status line at the bottom
set number            " Show line numbers on the left
set hidden            " Allow switching buffers without saving them first
set tabstop=4         " Number of spaces a <Tab> counts for
set shiftwidth=4      " Number of spaces to use for each step of indent
set autoindent        " Copy indent from current line when starting a new line
set expandtab         " Convert tab characters to spaces in insert mode

""" --- Keybindings ---
let mapleader = "\\"       " Set leader key to backslash (default)
imap jj <Esc>              " Quick escape from insert mode
nnoremap <c-j> 5<c-e>      " Scroll down faster
nnoremap <c-k> 5<c-y>      " Scroll up faster
nnoremap <leader>h :nohlsearch<CR> " Clear search highlights

" Trim trailing whitespace
nnoremap <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

""" --- Ctrl-P (FZF Native) ---
function! FZFOpen(command)
    let l:temp = tempname()
    execute 'silent !' . a:command . ' | fzf > ' . l:temp
    redraw!
    if filereadable(l:temp)
        let l:file = readfile(l:temp)
        if !empty(l:file) | execute 'edit ' . l:file[0] | endif
        call delete(l:temp)
    endif
endfunction
" Fuzzy find files excluding hidden .git directories
nnoremap <C-p> :call FZFOpen('find . -path "*/.*" -prune -o -type f -print')<CR>

""" --- Filetype Rules & UV Tools ---
augroup FileTypeOverrides
    autocmd!
    " Python: Basic Indentation & Settings
    autocmd FileType python setl ts=4 sts=4 sw=4 tw=100 et
    
    " Protected Format on Save (Calls the Lua function defined below)
    autocmd BufWritePre *.py lua format_python()

    " Python Mappings: <leader>l to lint, <leader>t to type check
    autocmd FileType python nnoremap <buffer> <leader>l :cexpr system('uv run ruff check ' . expand('%')) <bar> cw<CR>
    autocmd FileType python nnoremap <buffer> <leader>t :cexpr system('uv run ty ' . expand('%')) <bar> cw<CR>
    
    " Convenience abbreviations
    autocmd FileType python cabbrev <buffer> rff cexpr system('uv run ruff check ' . expand('%')) <bar> cw
    autocmd FileType python cabbrev <buffer> ty cexpr system('uv run ty ' . expand('%')) <bar> cw

    " Other languages
    autocmd FileType sql,sh,javascript,tf setl ts=2 sts=2 sw=2 et
    autocmd FileType markdown setl wrap linebreak
augroup END

""" --- Tools (<leader> + key) ---

" \w : Trim whitespace, then run normal mode commands gg=G (indent) and `` (jump back)
nnoremap <leader>w :%s/\s\+$//e<CR>gg=G``:nohlsearch<CR>

" --- GitHub Browse ---
function! Gbrowse() range
    call system('gh browse ' . expand('%') . ':' . a:firstline . '-' . a:lastline)
endfunction
command! -range Gbrowse <line1>,<line2>call Gbrowse()
cabbrev gb Gbrowse
nnoremap <leader>gb :Gbrowse<CR>
vnoremap <leader>gb :Gbrowse<CR>

" \h : Clear search highlights manually
nnoremap <leader>h :nohlsearch<CR>

""" --- Theme ---
colorscheme dracula
highlight Normal ctermbg=NONE guibg=NONE " Remove background for terminal transparency
highlight NonText ctermbg=NONE guibg=NONE " Remove background for end-of-buffer tildes
