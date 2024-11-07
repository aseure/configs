-------------------------------------------------------------------------------
-- Package manager
-------------------------------------------------------------------------------

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  { 'VonHeikemen/lsp-zero.nvim', branch = 'v4.x' },
  { 'hrsh7th/cmp-nvim-lsp' },
  { 'hrsh7th/nvim-cmp' },
  { 'kylechui/nvim-surround',    version = '*',  event = 'VeryLazy' },
  { 'neovim/nvim-lspconfig' },
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
    },
  },
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  { 'nvim-treesitter/nvim-treesitter',          build = ':TSUpdate' },
  { 'shaunsingh/nord.nvim' },
  { 'tpope/vim-fugitive' },
  { 'tpope/vim-vinegar' },
})

-------------------------------------------------------------------------------
-- Global configuration
-------------------------------------------------------------------------------

vim.g.mapleader = ' '
vim.g.netrw_banner = 0
vim.g.netrw_browse_split = 0
vim.g.netrw_winsize = 25

-- Window moves
vim.keymap.set('n', '<leader>k', '<C-w>k')
vim.keymap.set('n', '<leader>j', '<C-w>j')
vim.keymap.set('n', '<leader>h', '<C-w>h')
vim.keymap.set('n', '<leader>l', '<C-w>l')

vim.keymap.set('n', '<C-h>', ':noh<CR>')

-- Window splits
vim.keymap.set('n', '<leader>s', ':split<CR>')
vim.keymap.set('n', '<leader>v', ':vsplit<CR>')

vim.keymap.set('!', '<A-BS>', '<C-w>')
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', '<leader>b', '<C-o>')
vim.keymap.set('n', '<C-t>', vim.cmd.Ex)
vim.keymap.set('n', '<leader>n', '<C-i>')
vim.keymap.set('n', 'J', 'mzJ`z')
vim.keymap.set('n', 'N', 'Nzzzv')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'tj', ':bnext<CR>')
vim.keymap.set('n', 'tk', ':bprevious<CR>')
vim.keymap.set('n', 'tt', ':bdelete<CR>')
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")
vim.keymap.set('i', 'uu', '<Esc>')
vim.keymap.set('i', '<Tab>', '<Esc>')

vim.opt.clipboard = vim.opt.clipboard + 'unnamedplus'
vim.opt.colorcolumn = '80,120'
vim.opt.expandtab = true
vim.opt.foldenable = true
vim.opt.foldlevelstart = 99
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.nu = true
vim.opt.scrolloff = 8
vim.opt.shell = '/opt/homebrew/bin/zsh'
vim.opt.shiftwidth = 2
vim.opt.signcolumn = 'yes'
vim.opt.smartindent = true
vim.opt.softtabstop = 2
vim.opt.tabstop = 2
vim.opt.termguicolors = true
vim.opt.updatetime = 500

vim.api.nvim_create_autocmd('TermOpen', {
  pattern = '*',
  command = 'setlocal nonumber',
})

vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*',
  command = [[%s/\s\+$//e]],
})

-- Close the quickfix menu after selecting choice
vim.api.nvim_create_autocmd(
  'FileType', {
    pattern = { 'qf' },
    command = [[nnoremap <buffer> <CR> <CR>:cclose<CR>]]
  })

-------------------------------------------------------------------------------
-- Colorscheme
-------------------------------------------------------------------------------

vim.cmd.colorscheme('nord')

-------------------------------------------------------------------------------
-- Fuzzy file search
-------------------------------------------------------------------------------

local telescopeConfig = require('telescope.config')

local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }
table.insert(vimgrep_arguments, '--smart-case')

local telescope = require('telescope')
local actions = require('telescope.actions')

telescope.setup({
  defaults = {
    layout_strategy = 'vertical',
    layout_config = { height = 0.95, prompt_position = "top", mirror = true },
    sorting_strategy = "ascending",
    vimgrep_arguments = vimgrep_arguments,
  },
  pickers = {
    find_files = {
      mappings = {
        i = {
          ['<M-BS>'] = function() vim.api.nvim_input "<C-w>" end,
          ["<Tab>"] = actions.move_selection_worse,
          ["<S-Tab>"] = actions.move_selection_better,
        },
      },
    },
  },
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    },
    live_grep_args = {
      auto_quoting = true, -- enable/disable auto-quoting
      -- define mappings, e.g.
      mappings = {         -- extend mappings
        i = {
          ['<C-space>'] = actions.to_fuzzy_refine,
        },
      },
    },
  },
})

local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})

require('telescope').load_extension('fzf')

-------------------------------------------------------------------------------
-- LSP
-------------------------------------------------------------------------------

-- Add cmp_nvim_lsp capabilities settings to lspconfig
-- This should be executed before you configure any language server
local lspconfig_defaults = require('lspconfig').util.default_config
lspconfig_defaults.capabilities = vim.tbl_deep_extend(
  'force',
  lspconfig_defaults.capabilities,
  require('cmp_nvim_lsp').default_capabilities()
)

-- This is where you enable features that only work
-- if there is a language server active in the file
vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(event)
    local opts = { buffer = event.buf }

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
      vim.lsp.handlers.hover, { focusable = false }
    )

    vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
    vim.keymap.set('n', 'gd', builtin.lsp_definitions, opts)
    vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
    vim.keymap.set('n', 'gi', builtin.lsp_implementations, opts)
    vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
    vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
    vim.keymap.set('n', 'gr', builtin.lsp_references, opts)
    vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
    vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
    vim.keymap.set({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
    vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)

    local id = vim.tbl_get(event, 'data', 'client_id')
    local client = id and vim.lsp.get_client_by_id(id)
    if client ~= nil and client.supports_method('textDocument/formatting') then
      require('lsp-zero').buffer_autoformat()
    end
  end,
})

require('lspconfig').gopls.setup({})
require('lspconfig').ts_ls.setup({})
require('lspconfig').rust_analyzer.setup({})
require('lspconfig').terraformls.setup({})
require('lspconfig').salt_ls.setup({})
require('lspconfig').lua_ls.setup({
  on_init = function(client)
    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
      runtime = {
        version = 'LuaJIT',
      },
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME,
        },
        preloadFileSize = 10000,
      },
    })
    client.notify('workspace/didChangeConfiguration', { settings = client.config.settings })
  end,
  settings = {
    Lua = {}
  }
})

local cmp = require('cmp')

cmp.setup({
  sources = {
    { name = 'nvim_lsp' },
  },
  snippet = {
    expand = function(args)
      -- You need Neovim v0.10 to use vim.snippet
      vim.snippet.expand(args.body)
    end,
  },
  mapping = {
    ["<CR>"] = cmp.mapping.confirm({ select = false }),
    ["<Tab>"] = cmp.mapping.confirm({ select = false }),
  },
})

-------------------------------------------------------------------------------
-- Treesitter
-------------------------------------------------------------------------------

require 'nvim-treesitter.configs'.setup {
  ensure_installed = {
    'c',
    'go',
    'javascript',
    'json',
    'lua',
    'markdown',
    'markdown_inline',
    'query',
    'rust',
    'typescript',
    'vim',
    'vimdoc',
  },
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}

-------------------------------------------------------------------------------
-- Surround
-------------------------------------------------------------------------------

require('nvim-surround').setup({})
