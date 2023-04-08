vim.g.mapleader = ","

local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.vim/plugged')

Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'Raimondi/delimitMate'
Plug 'bronson/vim-trailing-whitespace'
Plug 'hanneskaeufler/bzlrun.nvim'
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
Plug('nvim-treesitter/nvim-treesitter', {
    ['do'] = function()
        vim.call('TSUpdate')
    end
})

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

-- Highlighting
require('nvim-treesitter.configs').setup {
  ensure_installed = {
    "c",
    "cpp",
    "rust",
    "bash",
    "gitignore",
    "gitcommit",
    "html",
    "json",
    "make",
    "markdown",
    "ruby",
    "typescript",
    "yaml",
    "lua",
    "vim",
    "help",
    "python"
  }
}

-- Language Server Stuff
require('mason').setup()
local servers = { 'clangd', 'rust_analyzer', 'jdtls' }

require('mason-lspconfig').setup {
    ensure_installed = servers,
}

local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local cmp = require('cmp')

cmp.setup {
    snippet = {
        expand = function(args)
            require('snippy').expand_snippet(args.body)
        end,
    },
    mapping = {
        ['<TAB>'] = {
          i = function()
            local cmp = require('cmp')
            local types = require('cmp.types')
            if cmp.visible() then
              cmp.select_next_item({ behavior = types.cmp.SelectBehavior.Insert })
            else
              cmp.complete()
            end
          end,
        },
        ['<S-TAB>'] = {
          i = function()
            local cmp = require('cmp')
            local types = require('cmp.types')
            if cmp.visible() then
              cmp.select_prev_item({ behavior = types.cmp.SelectBehavior.Insert })
            else
              cmp.complete()
            end
          end,
        },
        ["<CR>"] = {
            i = cmp.mapping.confirm({ select = false }),
        }
    },
    sources = cmp.config.sources {
        { name = 'nvim_lsp' },
        { name = 'buffer' },
    }
}

cmp.setup.cmdline(':', {
    sources = cmp.config.sources(
        { { name = 'path' } },
        { { name = 'cmdline' } })
})

local map = function(type, key, value)
    vim.api.nvim_buf_set_keymap(0, type, key, value, { noremap = true, silent = true })
end

local custom_attach = function(client)
    map('n','gD','<cmd>lua vim.lsp.buf.declaration()<CR>')
    map('n','gd','<cmd>lua vim.lsp.buf.definition()<CR>')
    map('n','<leader>ar','<cmd>lua vim.lsp.buf.rename()<CR>')
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

for _, lsp in ipairs(servers) do
    require('lspconfig')[lsp].setup {
        on_attach = custom_attach,
        capabilities = capabilities,
    }
end

-- Show git status in left number column
require('gitsigns').setup()

-- Run tests with bazel
local bzlrun = require('bzlrun')
vim.keymap.set("n", "<leader>t", bzlrun.run_tests_for_current_buffer)

vim.cmd('source ~/.vimrc')

-- Statusline
require('nvim-web-devicons').setup()
require('lualine').setup({
    sections = {
        lualine_b = {},
        lualine_x = {'diagnostics'},
        lualine_y = {'branch'}
    }
})
