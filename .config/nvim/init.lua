local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.vim/plugged')

Plug 'Raimondi/delimitMate'
Plug 'bronson/vim-trailing-whitespace'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'lewis6991/gitsigns.nvim'
Plug 'mhartington/oceanic-next'
Plug 'nvim-lua/plenary.nvim'
Plug 'pbrisbin/vim-mkdir'
Plug 'sbdchd/neoformat'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-surround'
Plug 'hanneskaeufler/bzlrun.nvim'

-- Language Server Stuff
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/nvim-cmp'
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'dcampos/nvim-snippy'
Plug 'dcampos/cmp-snippy'

vim.call('plug#end')

vim.cmd('source ~/.vimrc')
