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

command! -bang -nargs=* Ggrep
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

  cmp.setup({
    snippet = {
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
      { name = 'buffer' },
    })
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    sources = cmp.config.sources(
    { { name = 'path' } },
    { { name = 'cmdline' } })
  })

  -- Setup lspconfig.
  local map = function(type, key, value)
  	vim.api.nvim_buf_set_keymap(0,type,key,value,{noremap = true, silent = true});
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

lua << EOF
local bzlrun = require('bzlrun')
vim.keymap.set("n", "<leader>t", bzlrun.run_tests_for_current_buffer)
EOF

" vim:foldmethod=marker:foldlevel=0
