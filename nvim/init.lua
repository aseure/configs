-------------------------------------------------------------------------------
-- Plugins
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
  { 'hrsh7th/cmp-cmdline' },
  { 'hrsh7th/cmp-nvim-lsp' },
  { 'hrsh7th/nvim-cmp' },
  { 'kylechui/nvim-surround',                   version = '*',         event = 'VeryLazy' },
  { 'lukas-reineke/indent-blankline.nvim',      main = 'ibl',          opts = {}, },
  { 'lukas-reineke/lsp-format.nvim' },
  { 'lukas-reineke/virt-column.nvim' },
  { 'neovim/nvim-lspconfig' },
  { 'numToStr/Comment.nvim' },
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  { 'nvim-telescope/telescope.nvim',            branch = '0.1.x',      dependencies = { { 'nvim-lua/plenary.nvim' } } },
  { 'nvim-treesitter/nvim-treesitter',          build = ':TSUpdate' },
  { 'nvim-treesitter/nvim-treesitter-refactor' },
  { 'shaunsingh/nord.nvim' },
  { 'stevearc/oil.nvim' },
  { 'tpope/vim-fugitive' },
  { 'williamboman/mason-lspconfig.nvim' },
  { 'williamboman/mason.nvim' },
  { 'windwp/nvim-autopairs',                    event = "InsertEnter", config = true },
})

-------------------------------------------------------------------------------
-- Global configuration
-------------------------------------------------------------------------------

-- Define leader key
vim.g.mapleader = ' '

-- Window moves
vim.keymap.set('n', '<leader>k', '<C-w>k')
vim.keymap.set('n', '<leader>j', '<C-w>j')
vim.keymap.set('n', '<leader>h', '<C-w>h')
vim.keymap.set('n', '<leader>l', '<C-w>l')

-- Hide highlighting for search results
vim.keymap.set('n', '<C-h>', ':noh<CR>')

-- Window splits
vim.keymap.set('n', '<leader>s', ':split<CR>')
vim.keymap.set('n', '<leader>v', ':vsplit<CR>')

-- Navigate up and down while keeping the buffer centered
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

-- Ensure Alt-Backspace works the way it should
vim.keymap.set('!', '<A-BS>', '<C-w>')

-- Navigate back and forth in jump locations
vim.keymap.set('n', '<A-[>', '<C-o>')
vim.keymap.set('n', '<A-]>', '<C-i>')

-- Stack up lines
vim.keymap.set('n', 'J', 'mzJ`z')

-- Go to next search result while keeping the buffer centered
vim.keymap.set('n', 'N', 'Nzzzv')
vim.keymap.set('n', 'n', 'nzzzv')

-- Close the current buffer
vim.keymap.set('n', 'tt', ':bdelete<CR>')

-- Move lines up and down
vim.keymap.set('n', '<A-S-Up>', ':m .-2<CR>==')
vim.keymap.set('n', '<A-S-Down>', ':m .+1<CR>==')
vim.keymap.set('v', '<A-S-Up>', ":m '<-2<CR>gv=gv")
vim.keymap.set('v', '<A-S-Down>', ":m '>+1<CR>gv=gv")

vim.keymap.set('n', '<leader>ww', ':w<CR>')
vim.keymap.set('n', '<leader>wa', ':wa<CR>')

-- Enter insert mode with proper indentation
vim.keymap.set('n', 'i', function()
  return string.match(vim.api.nvim_get_current_line(), '%g') == nil
    and 'cc' or 'i'
end, { expr = true, noremap = true })

vim.opt.clipboard = vim.opt.clipboard + 'unnamedplus'
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
vim.opt.smartindent = false
vim.opt.softtabstop = 2
vim.opt.tabstop = 2
vim.opt.termguicolors = true
vim.opt.updatetime = 100

vim.wo.wrap = false

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
-- Virtual columns
-------------------------------------------------------------------------------

require('virt-column').setup({
  virtcolumn = '80,120'
})

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
vim.keymap.set('n', '<C-p>', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})

require('telescope').load_extension('fzf')

-------------------------------------------------------------------------------
-- Treesitter
-------------------------------------------------------------------------------

vim.api.nvim_set_hl(0, "TSDefinitionUsage", { bg = "#414c60" })
vim.api.nvim_set_hl(0, "TSDefinition", { bg = "#414c60" })

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
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<M-Up>",
      node_incremental = "<M-Up>",
      node_decremental = "<M-Down>",
    }
  },
  indent = { enable = true },
  refactor = {
    highlight_definitions = {
      enable = true,
      clear_on_cursor_move = false,
    },
  }
}

-------------------------------------------------------------------------------
-- Surround
-------------------------------------------------------------------------------

require('nvim-surround').setup({})

-------------------------------------------------------------------------------
-- Comment
-------------------------------------------------------------------------------

require('Comment').setup({
  toggler = {
    line = '<leader>cc',
  },
  opleader = {
    line = '<leader>cc',
  },
})

-------------------------------------------------------------------------------
-- Oil
-------------------------------------------------------------------------------

require('oil').setup({
  skip_confirm_for_simple_edits = true,
})

vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-------------------------------------------------------------------------------
-- LSP
-------------------------------------------------------------------------------

local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require('cmp')
local handlers = require('nvim-autopairs.completion.handlers')

local cmp_next = function()
  local cmp = require('cmp')
  if cmp.visible() then
    cmp.select_next_item()
  else
    cmp.complete()
  end
end

local cmp_prev = function()
  local cmp = require('cmp')
  if cmp.visible() then
    cmp.select_prev_item()
  else
    cmp.complete()
  end
end

local custom_mappings = {
  ["<CR>"] = cmp.mapping.confirm({ select = true }),
  ["<Tab>"] = cmp.mapping.confirm({ select = true }),
  ["<C-n>"] = { c = cmp_next, i = cmp_next },
  ["<Down>"] = { c = cmp_next, i = cmp_next },
  ["<C-p>"] = { c = cmp_prev, i = cmp_prev },
  ["<Up>"] = { c = cmp_prev, i = cmp_prev },
}

cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)

cmp.setup({
  sources = {
    { name = 'nvim_lsp' },
  },
  snippet = {
    expand = function(args)
      vim.snippet.expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert(custom_mappings),
  window = {
    completion = {
      border = nil,
      scrollbar = '',
    },
    documentation = {
      border = nil,
      scrollbar = '',
    },
  },
})


cmp.setup.cmdline({
  mapping = cmp.mapping.preset.cmdline(custom_mappings),
})

cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(custom_mappings),
  sources = {
    { name = 'buffer' }
  }
})

cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(custom_mappings),
  sources = cmp.config.sources({
    { name = 'cmd_line' }
  }, {
      {
        name = 'cmdline',
        option = {
          ignore_cmds = { 'Man', '!' }
        }
      }
    })
})


local cmp_lsp = require('cmp_nvim_lsp')
local lspconfig_defaults = require('lspconfig').util.default_config

lspconfig_defaults.capabilities = vim.tbl_deep_extend(
  'force',
  lspconfig_defaults.capabilities,
  cmp_lsp.default_capabilities()
)

-- This is where you enable features that only work
-- if there is a language server active in the file
vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(event)
    local opts = { buffer = event.buf }

    -- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
    --   vim.lsp.handlers.hover, { focusable = false }
    -- )

    vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
    vim.keymap.set('n', 'gd', builtin.lsp_definitions, opts)
    vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
    vim.keymap.set('n', 'gi', builtin.lsp_implementations, opts)
    vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
    vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
    vim.keymap.set('n', 'gr', builtin.lsp_references, opts)
    vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
    vim.keymap.set('n', 'gR', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
    vim.keymap.set('n', 'gf', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
    vim.keymap.set('n', '<M-Enter>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
  end,
})


local border = "single"

local default_setup = function(server)
  require('lspconfig')[server].setup({
    on_attach = require('lsp-format').on_attach,
    capabilities = cmp_lsp.default_capabilities(),
    handlers = {
      ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
      ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
    },
  })
end

require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {
    'gopls',
    'lua_ls',
    'rust_analyzer',
    'terraformls',
    'ts_ls',
  },
  handlers = {
    default_setup,
    lua_ls = function()
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
    end,
  },
})


vim.keymap.set('n', '<M-.>', function() vim.diagnostic.open_float({ focus = false }) end)
vim.keymap.set('n', '[d', function() vim.diagnostic.goto_prev() end, opts)
vim.keymap.set('n', ']d', function() vim.diagnostic.goto_next() end, opts)

vim.diagnostic.config({
  virtual_text = false,
  float = {
    header = "",
    border = "rounded"
  }
})

vim.api.nvim_set_hl(0, "LspDiagnosticsUnderlineWarning", { undercurl = true, sp = "#414c60" })
vim.api.nvim_set_hl(0, "LspDiagnosticsUnderlineError", { underline = true, sp = "#bf616a", fg = "#bf616a" })
vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#394253" })
