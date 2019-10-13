set nocompatible
filetype off

" Vundle setup
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'

" Vundle plugins here
Plugin 'sheerun/vim-polyglot'
Plugin 'tomasr/molokai'
Plugin 'bronson/vim-trailing-whitespace'
Plugin 'tpope/vim-commentary'
Plugin 'rking/ag.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'w0rp/ale'
Plugin 'tpope/vim-surround'
Plugin 'airblade/vim-gitgutter'
Plugin 'Raimondi/delimitMate'

" Vundle teardown
call vundle#end()

filetype plugin indent on

syntax on

colorscheme molokai

set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set colorcolumn=80

set autoindent
set incsearch
set hlsearch
set ignorecase smartcase
set relativenumber
" keep more context when scrolling off the end of a buffer
set scrolloff=3
" always show status bar
set laststatus=2

" Store temporary files in a central spot
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set viminfo=

let mapleader=","

" use jj to exit insert mode
inoremap jj <ESC>

" Move around splits with <c-hjkl>
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" move vertically by visual line
nnoremap j gj
nnoremap k gk

" save files with ctrl-s
noremap <C-S> :update<CR>

nmap <leader>e :Explore<CR>
nmap <leader>f <C-W>_
nmap <leader>uf <C-W>=

" search for word under cursor
nmap <leader>s :Ag <C-r><C-w><CR>

" CocoaPods
autocmd BufNewFile,BufRead Podfile,*.podspec set filetype=ruby

" Clear the search buffer when hitting return
nnoremap <CR> :nohlsearch<cr>

" indention for yaml, scss, ruby with 2 spaces
autocmd BufNewFile,BufRead *.yml set filetype=yaml
autocmd FileType yaml setlocal sw=2 st=2 sts=2
autocmd FileType scss setlocal sw=4 st=4 sts=4
autocmd FileType ruby setlocal sw=2 st=2 sts=2
autocmd FileType crystal setlocal sw=2 st=2 sts=2
autocmd FileType javascript setlocal sw=2 st=2 sts=2
autocmd FileType typescript setlocal sw=2 st=2 sts=2
autocmd FileType elm setlocal colorcolumn=

set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/vendor/*,*/node_modules/*,*/web/assets/*

let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/](\.)?(git|hg|svn|docs)$',
    \ 'file': '\v\.(exe|so|dll|cache\.php)$'
    \ }
let g:ctrlp_map = '<c-p>'

nmap <Leader>b :! clear && make<CR>
nmap <Leader>d :ALEDetail<CR>

set completeopt-=preview

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MULTIPURPOSE TAB KEY
" Indent if we're at the beginning of a line. Else, do completion.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <expr> <tab> InsertTabWrapper()
inoremap <s-tab> <c-n>
