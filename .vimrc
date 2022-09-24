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
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'lewis6991/gitsigns.nvim'
Plug 'mhartington/oceanic-next'
Plug 'nvim-lua/plenary.nvim'
Plug 'pbrisbin/vim-mkdir'
Plug 'sbdchd/neoformat'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-surround'
Plug 'sheerun/vim-polyglot'

" Autocomplete
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/nvim-cmp'
Plug 'neovim/nvim-lspconfig'
Plug 'dcampos/nvim-snippy'
Plug 'dcampos/cmp-snippy'
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

lua << EOF
require('gitsigns').setup()
EOF

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

command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number -- '.shellescape(<q-args>), 0,
  \   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)

" }}}

" Autocomplete configuration {{{

set nobackup
set nowritebackup
set cmdheight=2
set hidden
set updatetime=300
set shortmess+=c
set signcolumn=yes
set completeopt=menu,menuone,noselect

lua <<EOF
  local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  end

  -- Setup nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        require('snippy').expand_snippet(args.body)
      end,
    },
    mapping = {
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          else
            fallback()
          end
        end, { "i", "s" }),

    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it. 
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
      { name = 'path' }
    }
    , { { name = 'cmdline' } }
)
  })

  -- Setup lspconfig.
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

  require('lspconfig').rust_analyzer.setup {
      capabilities = capabilities
    }
  require'lspconfig'.clangd.setup {
    capabilities = capabilities
  }
EOF


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
