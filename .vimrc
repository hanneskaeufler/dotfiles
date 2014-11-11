set nocompatible
filetype off

" Vundle setup
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'

" Vundle plugins here
Plugin 'Valloric/YouCompleteMe'
Plugin 'tomasr/molokai'
Plugin 'benmills/vimux'
Plugin 'bronson/vim-trailing-whitespace'
Plugin 'tpope/vim-commentary'
Plugin 'kchmck/vim-coffee-script'
Plugin 'sunaku/vim-ruby-minitest'
Plugin 'rking/ag.vim'

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
set number
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

:set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%)

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

" Find all files in all non-dot directories starting in the working directory.
" Fuzzy select one of those. Open the selected file with :e.
nnoremap <c-P> :call SelectaCommand("find * -type f", "", ":e")<cr>

" Generate PhpDoc
map <leader>d :call PhpDocSingle()<CR>
map <leader>e :Explore<CR>
map <leader>f <C-W>_
map <leader>uf <C-W>=

" CocoaPods
autocmd BufNewFile,BufRead Podfile,*.podspec set filetype=ruby

" Clear the search buffer when hitting return
:nnoremap <CR> :nohlsearch<cr>

" indention for yaml with 2 spaces
autocmd BufNewFile,BufRead *.yml set filetype=yaml
autocmd FileType yaml setlocal sw=2 sts=2
