" Essentials {{{
inoremap jj <ESC>

" Move around splits with <c-hjkl>
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

let mapleader=","

nmap <leader>e :Explore<CR>
nmap <leader>f <C-W>_
nmap <leader>uf <C-W>=
nmap <CR> :nohlsearch<CR>
nmap <leader>n :cnext<CR>
nmap <leader>p :cprevious<CR>
nmap <leader>gh :GBrowse<CR>

" move vertically by visual line
nnoremap j gj
nnoremap k gk

set nocompatible
set relativenumber
set number
set expandtab
" }}}

"  Plugins, duh {{{
call plug#begin('~/.vim/plugged')
Plug 'Raimondi/delimitMate'
Plug 'bronson/vim-trailing-whitespace'
Plug 'janko/vim-test'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'mhartington/oceanic-next'
Plug 'pbrisbin/vim-mkdir'
Plug 'sbdchd/neoformat'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'
call plug#end()
" }}}

" Colors {{{
colorscheme OceanicNext
" }}}

" Spaces & Tabs {{{
set tabstop=4
set shiftwidth=4
set softtabstop=4
" }}}

" UI config {{{
set colorcolumn=80
set scrolloff=3 " keep more context when scrolling off the end of a buffer
set laststatus=2 " always show status bar
"}}}

" Dunno / Misc {{{
set noswapfile
set autoindent
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/vendor/*,*/node_modules/*,*/web/assets/*
set viminfo=
set modelines=1 " Respect the modes defines as a comment on the last line
" }}}

" Search {{{
set incsearch
set hlsearch
set ignorecase smartcase
" }}}

" COC configuration {{{

" settings recommended by coc.nvim
" https://github.com/neoclide/coc.nvim#example-vim-configuration
set nobackup
set nowritebackup
set cmdheight=2
set hidden
set updatetime=300
set shortmess+=c
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use K for show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
    if &filetype == 'vim'
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Symbol renaming. (mnemonic: rename)
nmap <leader>rn <Plug>(coc-rename)

" Go to definition of symbol under cursor. (mnemonic: goto definition)
nmap <silent> <leader>gd <Plug>(coc-definition)

" }}}

" File navigation {{{
nmap <C-p> :GFiles<CR>
let g:netrw_banner = 0 " remove banner in explorer
let g:netrw_liststyle = 3 " use tree view in
" }}}

" Language specifics {{{
autocmd FileType elm setlocal colorcolumn= " Using elm-format this is enforced automatically, no point in showing the line then
autocmd FileType crystal setlocal shiftwidth=2 softtabstop=2
autocmd FileType javascript setlocal shiftwidth=2 softtabstop=2
autocmd BufNewFile,BufRead Podfile,*.podspec set filetype=ruby " CocoaPods
" }}}

" Running tests {{{
nmap <silent> <leader>t :TestSuite<CR>

" When opening the test output in a new split, hitting ctrl-o
" will leave insert mode and allow me to scroll
if has('nvim')
  tmap jj <C-\><C-n>
endif
" }}}

" Neoformat configuration {{{
augroup fmt
  autocmd!
  autocmd BufWritePre * undojoin | Neoformat
augroup END
" }}}

" vim:foldmethod=marker:foldlevel=0
