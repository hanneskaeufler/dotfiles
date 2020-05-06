set nocompatible
filetype off

" Vundle setup
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'

" Vundle plugins here
Plugin 'Raimondi/delimitMate'
Plugin 'bronson/vim-trailing-whitespace'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'janko/vim-test'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'neoclide/coc.nvim'
Plugin 'sainnhe/vim-color-desert-night'
Plugin 'sbdchd/neoformat'
Plugin 'sheerun/vim-polyglot'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-rhubarb'
Plugin 'tpope/vim-surround'

" Vundle teardown
call vundle#end()

filetype plugin indent on

syntax on

colorscheme desert-night

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
set number
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

autocmd FileType elm setlocal colorcolumn= " Using elm-format this is enforced automatically
autocmd FileType crystal setlocal shiftwidth=2 softtabstop=2
autocmd FileType javascript setlocal shiftwidth=2 softtabstop=2

set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/vendor/*,*/node_modules/*,*/web/assets/*

nmap <Leader>l :VimuxRunLastCommand<CR>

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

nmap <C-p> :GFiles<CR>

let g:netrw_banner = 0 " remove banner in explorer
let g:netrw_liststyle = 3 " use tree view in

let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

let g:neoformat_verbose = 1
let g:neoformat_crystal_docker = {
            \ 'exe': 'docker',
            \ 'args': ['run', '--rm', '-v "$(pwd):/tmp"', '-w', '/tmp', 'crystallang/crystal:0.32.0', 'crystal', 'tool', 'format'],
            \ 'replace': 1,
            \ 'no_append': 1,
            \ }

let g:neoformat_enabled_crystal = ['docker']

autocmd BufWritePre *.js Neoformat prettier

nmap <silent> <leader>t :TestSuite<CR>

if has('nvim')
  tmap <C-o> <C-\><C-n>
endif
