vim.g.mapleader = ","

vim.pack.add({
 'https://github.com/nvim-lualine/lualine.nvim',
 'https://github.com/nvim-tree/nvim-web-devicons',
 'https://github.com/Raimondi/delimitMate',
 'https://github.com/bronson/vim-trailing-whitespace',
 'https://github.com/hanneskaeufler/bzlrun.nvim',
 'https://github.com/nvim-lua/plenary.nvim',
 { src = 'https://github.com/nvim-telescope/telescope.nvim', version = 'v0.1.9' },
 'https://github.com/nvim-telescope/telescope-ui-select.nvim',
 'https://github.com/lewis6991/gitsigns.nvim',
 'https://github.com/mhartington/oceanic-next',
 'https://github.com/pbrisbin/vim-mkdir',
 'https://github.com/sbdchd/neoformat',
 'https://github.com/sheerun/vim-polyglot',
 'https://github.com/stevearc/oil.nvim',
 'https://github.com/tpope/vim-endwise',
 'https://github.com/tpope/vim-surround',
 'https://github.com/github/copilot.vim',
 'https://github.com/k2589/getgithublink.nvim',

-- Language Server Stuff
 'https://github.com/hrsh7th/cmp-buffer',
 'https://github.com/hrsh7th/cmp-cmdline',
 'https://github.com/hrsh7th/cmp-nvim-lsp',
 'https://github.com/hrsh7th/cmp-path',
 'https://github.com/hrsh7th/nvim-cmp',
 'https://github.com/neovim/nvim-lspconfig',
 'https://github.com/williamboman/mason.nvim',
 'https://github.com/williamboman/mason-lspconfig.nvim',
 'https://github.com/dcampos/nvim-snippy',
 'https://github.com/dcampos/cmp-snippy',
})

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

-- Buffer diagnostics

vim.keymap.set("n", "<leader>w", function()
  require("telescope.builtin").diagnostics({
    layout_strategy = "center",
    layout_config = {
      height = 0.6,
      width = 0.6,
    }
  })
end, { desc = "Show LSP diagnostics" })

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
        },
        live_grep = {
          additional_args = function(_)
              return { "--hidden" }
          end
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
