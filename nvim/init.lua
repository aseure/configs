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
  { 'L3MON4D3/LuaSnip' },
  { 'NLKNguyen/papercolor-theme' },
  { 'VonHeikemen/lsp-zero.nvim',       branch = 'v3.x' },
  { 'airblade/vim-gitgutter' },
  { 'chrisbra/Colorizer' },
  { 'folke/zen-mode.nvim' },
  { 'hrsh7th/cmp-nvim-lsp' },
  { 'hrsh7th/nvim-cmp' },
  { 'kevinhwang91/nvim-ufo' },
  { 'kylechui/nvim-surround' },
  { 'neovim/nvim-lspconfig' },
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  { 'nvim-telescope/telescope.nvim', branch = '0.1.x', dependencies = { 'nvim-lua/plenary.nvim' } },
  { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
  { 'pappasam/papercolor-theme-slim' },
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

-- Window resize
vim.keymap.set('n', '<C-k>', ':resize -2<CR>')
vim.keymap.set('n', '<C-j>', ':resize +2<CR>')
vim.keymap.set('n', '<C-h>', ':vertical resize -2<CR>')
vim.keymap.set('n', '<C-l>', ':vertical resize +2<CR>')

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
vim.opt.smartindent = true
vim.opt.softtabstop = 2
vim.opt.tabstop = 2
vim.opt.termguicolors = true
vim.opt.updatetime = 50

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
  pattern={'qf'},
  command=[[nnoremap <buffer> <CR> <CR>:cclose<CR>]]
})

-------------------------------------------------------------------------------
-- Colorscheme
-------------------------------------------------------------------------------

vim.cmd.colorscheme('nord')

-------------------------------------------------------------------------------
-- LSP
-------------------------------------------------------------------------------

local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
  lsp_zero.default_keymaps({ buffer = bufnr })

  vim.keymap.set('n', '<leader>f', vim.lsp.buf.format)
  vim.keymap.set('n', '<leader>.', vim.lsp.buf.hover)
end)

lsp_zero.set_sign_icons({})

require('lspconfig').gopls.setup({})
require('lspconfig').tsserver.setup({})
require('lspconfig').rust_analyzer.setup({})
require('lspconfig').terraformls.setup({})
require('lspconfig').salt_ls.setup({})
require('lspconfig').lua_ls.setup({
  on_init = function(client)
    client.config.settings = vim.tbl_deep_extend('force', client.config.settings, {
      Lua = {
        workspace = {
          preloadFileSize = 10000
        },
      },
    })
    client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
  end
})

local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

cmp.setup({
  mapping = cmp.mapping.preset.insert({
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<Tab>'] = cmp_action.tab_complete(),
    ['<S-Tab>'] = cmp_action.select_prev_or_fallback(),
  }),
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  }
})

vim.lsp.inlay_hint.enable()

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

-------------------------------------------------------------------------------
-- Fuzzy file search
-------------------------------------------------------------------------------

local telescopeConfig = require("telescope.config")

local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }
table.insert(vimgrep_arguments, "--smart-case")

local telescope = require('telescope')
local actions = require('telescope.actions')

telescope.setup({
  defaults = {
    layout_strategy = 'vertical',
    layout_config = { height = 0.95 },
    vimgrep_arguments = vimgrep_arguments,
  },
  pickers = {
    find_files = {
      mappings = {
        i = {
          ['<C-j>'] = actions.move_selection_next,
          ['<C-k>'] = actions.move_selection_previous,
        },
      },
    },
  },
})

local builtin = require('telescope.builtin')

vim.keymap.set('n', '<C-s>', builtin.buffers, {})
vim.keymap.set('n', '<C-p>', builtin.find_files, {})
vim.keymap.set('n', '<C-f>', builtin.live_grep, {})

require('telescope').load_extension('fzf')

-------------------------------------------------------------------------------
-- Zen mode
-------------------------------------------------------------------------------

local zen = require('zen-mode')

zen.setup({
  window = {
    backdrop = 1,
    width = 150,
  },
})

vim.keymap.set('n', '<leader>z', zen.toggle, {})
