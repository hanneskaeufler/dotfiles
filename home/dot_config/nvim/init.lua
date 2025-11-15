vim.g.mapleader = ","

local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.vim/plugged')

Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'Raimondi/delimitMate'
Plug 'bronson/vim-trailing-whitespace'
Plug 'hanneskaeufler/bzlrun.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug('nvim-telescope/telescope.nvim', { ['tag'] = 'v0.1.9' })
Plug 'nvim-telescope/telescope-ui-select.nvim'
Plug 'lewis6991/gitsigns.nvim'
Plug 'mhartington/oceanic-next'
Plug 'pbrisbin/vim-mkdir'
Plug 'sbdchd/neoformat'
Plug 'sheerun/vim-polyglot'
Plug 'stevearc/oil.nvim'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-surround'
Plug 'github/copilot.vim'
Plug('nvim-treesitter/nvim-treesitter', {
    ['do'] = function()
        vim.call('TSUpdate')
    end
})
Plug 'k2589/getgithublink.nvim'

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
local servers = { 'clangd', 'rust_analyzer', 'jdtls', 'helm_ls', 'ruff', 'gopls'}

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

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

local custom_attach = function(client)
    map('n','gD','<cmd>lua vim.lsp.buf.declaration()<CR>')
    map('n','gd','<cmd>lua vim.lsp.buf.definition()<CR>')
    map('n','<leader>r','<cmd>lua vim.lsp.buf.rename()<CR>')
    map('n','<leader>a', '<cmd>lua vim.lsp.buf.code_action()<CR>')
    map('n','<leader>d', '<cmd>lua vim.diagnostic.open_float()<CR>')
    map('n','<leader>s', '<cmd>lua vim.lsp.buf.hover()<CR>')
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

for _, lsp in ipairs(servers) do
    vim.lsp.config(lsp, {
        on_attach = custom_attach,
        capabilities = capabilities,
    })
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

-- File navigation / Project wide search
require('telescope').setup({
    pickers = {
        git_files = {
            show_untracked = true
        }
    },
    defaults = {
        path_display = { "truncate" },
    },
})

require("telescope").load_extension("ui-select")

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<C-s>', builtin.live_grep, {})

-- File Explorer
require("oil").setup({
  default_file_explorer = true,
  use_default_keymaps = true,
  view_options = {
    show_hidden = true,
    is_always_hidden = function(name, bufnr)
      return name:match(".git$")
    end,
  },
  keymaps = {
    ["<C-p>"] = false,
  }
})

vim.keymap.set("n", "<leader>e", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- Copilot
vim.keymap.set('i', '<C-J>', 'copilot#Accept("\\<CR>")', {
    expr = true,
    replace_keycodes = false
})
vim.g.copilot_no_tab_map = true

require("getgithublink").setup()
