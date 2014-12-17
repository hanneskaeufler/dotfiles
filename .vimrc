set nocompatible
filetype off

" Vundle setup
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'

" Vundle plugins here
Plugin 'Valloric/YouCompleteMe'
Plugin 'tomasr/molokai'
Plugin 'bronson/vim-trailing-whitespace'
Plugin 'tpope/vim-commentary'
Plugin 'kchmck/vim-coffee-script'
Plugin 'rking/ag.vim'
Plugin 'ekalinin/Dockerfile.vim'
Plugin 'jeffkreeftmeijer/vim-numbertoggle'
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/syntastic'
Plugin 'jgdavey/tslime.vim'
Plugin 'beyondwords/vim-twig'

" Vundle teardown
call vundle#end()

filetype plugin indent on

syntax on

colorscheme molokai

set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set colorcolumn=120

set autoindent
set incsearch
set hlsearch
set ignorecase smartcase
set relativenumber
" keep more context when scrolling off the end of a buffer
set scrolloff=3

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

" save files with ctrl-s
noremap <C-S> :update<CR>

" Run a given vim command on the results of fuzzy selecting from a given shell
" command. See usage below.
function! SelectaCommand(choice_command, selecta_args, vim_command)
  try
    silent let selection = system(a:choice_command . " | selecta " . a:selecta_args)
  catch /Vim:Interrupt/
    " Swallow the ^C so that the redraw below happens; otherwise there will be
    " leftovers from selecta on the screen
    redraw!
    return
  endtry
  redraw!
  exec a:vim_command . " " . selection
endfunction

nmap <leader>e :Explore<CR>
nmap <leader>f <C-W>_
nmap <leader>uf <C-W>=
nmap <leader>ta :execute ":Tmux ./bin/phpunit -c app/" expand("%")<CR>
nmap <leader>tf :execute ":Tmux ./bin/phpunit -c app/" expand("%")<CR>
nmap <leader>tt :execute ":Tmux ./bin/phpunit -c app/ --filter=test_show$" expand("%")<CR>

" CocoaPods
autocmd BufNewFile,BufRead Podfile,*.podspec set filetype=ruby

" Clear the search buffer when hitting return
nnoremap <CR> :nohlsearch<cr>

" indention for yaml, scss, ruby with 2 spaces
autocmd BufNewFile,BufRead *.yml set filetype=yaml
autocmd FileType yaml setlocal sw=2 st=2 sts=2
autocmd FileType scss setlocal sw=2 st=2 sts=2
autocmd FileType ruby setlocal sw=2 st=2 sts=2

set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/vendor/*,*/node_modules/*,*/web/assets/*

let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/]\.(git|hg|svn)$',
    \ 'file': '\v\.(exe|so|dll|cache\.php)$'
    \ }
let g:ctrlp_map = '<c-p>'

let g:syntastic_mode_map = {
    \ "mode": "active",
    \ "passive_filetypes": ["html"]
    \ }
