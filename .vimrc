" Essentials {{{
inoremap jj <ESC>

" Move around splits with <c-hjkl>
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

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
set termguicolors
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
set cmdheight=2
set updatetime=300
set signcolumn=yes
"}}}

" Dunno / Misc {{{
set noswapfile
set nobackup
set nowritebackup
set viminfo=
set autoindent
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/vendor/*,*/node_modules/*,*/web/assets/*
set modelines=1 " Respect the modes defined as a comment on the last line
set hidden
set shortmess+=c
set completeopt=menu,menuone,noselect
" }}}

" Search {{{
set incsearch
set hlsearch
set ignorecase smartcase

command! -bang -nargs=* Ggrep
  \ call fzf#vim#grep(
  \   'git grep --line-number -- '.shellescape(<q-args>), 0,
  \   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)
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

" Neoformat configuration {{{
augroup fmt
  autocmd!
  autocmd BufWritePre * undojoin | Neoformat
augroup END
" }}}

" vim:foldmethod=marker:foldlevel=0
