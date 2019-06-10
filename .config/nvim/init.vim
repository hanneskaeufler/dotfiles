filetype plugin indent on
syntax on

inoremap jj <esc>

" Move around splits with <c-hjkl>
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

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
set scrolloff=3
set laststatus=2
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set viminfo=
set guicursor=

let mapleader=","
nmap <leader>e :Explore<CR>
nmap <leader>f <C-W>_
nmap <leader>uf <C-W>=

let g:ale_cpp_clangtidy_options = '-x c++'
let g:clang_format#detect_style_file = 1
let g:ale_completion_enabled = 1
let g:ale_cpp_clang_options = '-std=c++17 -Wall'

" set the runtime path to include Vundle and initialize
set rtp+=~/.config/nvim/bundle/Vundle.vim
call vundle#begin('~/.config/nvim/bundle')
Plugin 'VundleVim/Vundle.vim'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'tomasr/molokai'
Plugin 'rhysd/vim-clang-format'
Plugin 'w0rp/ale'
Plugin 'ctrlpvim/ctrlp.vim'
" Plugin 'neoclide/coc.nvim'
Plugin 'Raimondi/delimitMate'

" All of your Plugins must be added before the following line
call vundle#end()

colorscheme molokai
autocmd FileType cpp ClangFormatAutoEnable

" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
