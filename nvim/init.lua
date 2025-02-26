-------------------------------------------------------------------------------
-- Plugins
-------------------------------------------------------------------------------

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	-- Git GitHub
	{ "lewis6991/gitsigns.nvim" },
	{ "tpope/vim-fugitive" },
	{ "trevorhauter/gitportal.nvim" },
	-- UI
	{ "onsails/lspkind.nvim" },
	{ "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
	{ "lukas-reineke/virt-column.nvim" },
	{ "shaunsingh/nord.nvim" },
	-- Navigation
	{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope-live-grep-args.nvim", version = "^1.0.0" },
		},
	},
	{ "stevearc/oil.nvim" },
	-- Editing
	{ "kevinhwang91/nvim-ufo", dependencies = { "kevinhwang91/promise-async" } },
	{ "kylechui/nvim-surround", version = "*", event = "VeryLazy" },
	{ "numToStr/Comment.nvim" },
	{ "stevearc/conform.nvim" },
	{ "windwp/nvim-autopairs", event = "InsertEnter", config = true },
	-- Tree-sitter
	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
	{ "nvim-treesitter/nvim-treesitter-refactor" },
	-- LSP
	{ "folke/trouble.nvim" },
	{ "hrsh7th/cmp-buffer" },
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/cmp-path" },
	{ "hrsh7th/nvim-cmp" },
	{ "neovim/nvim-lspconfig" },
	{ "zbirenbaum/copilot-cmp" },
	{ "zbirenbaum/copilot.lua" },
})

-------------------------------------------------------------------------------
-- Global configuration
-------------------------------------------------------------------------------

-- Define leader key
vim.g.mapleader = " "

-- Window moves
vim.keymap.set("n", "<leader>wk", "<C-w>k")
vim.keymap.set("n", "<leader>wj", "<C-w>j")
vim.keymap.set("n", "<leader>wh", "<C-w>h")
vim.keymap.set("n", "<leader>wl", "<C-w>l")
vim.keymap.set("n", "<leader>ww", "<C-w>c")
vim.keymap.set("n", "<leader>ws", ":split<CR>")
vim.keymap.set("n", "<leader>wv", ":vsplit<CR>")
vim.keymap.set("n", "<leader>wo", ":only<CR>")

-- Hide highlighting for search results
vim.keymap.set("n", "<C-h>", ":noh<CR>")

-- Navigate up and down while keeping the buffer centered
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Ensure Alt-Backspace works the way it should
vim.keymap.set("!", "<A-BS>", "<C-w>")

-- Navigate back and forth in jump locations
vim.keymap.set("n", "<A-[>", "<C-o>")
vim.keymap.set("n", "<A-]>", "<C-i>")

-- Stack up lines
vim.keymap.set("n", "J", "mzJ`z")

-- Go to next search result while keeping the buffer centered
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "n", "nzzzv")

-- Close the current buffer
vim.keymap.set("n", "<leader>bb", ":close<CR>")

-- Enter insert mode with proper indentation
vim.keymap.set("n", "i", function()
	return string.match(vim.api.nvim_get_current_line(), "%g") == nil and "cc" or "i"
end, { expr = true, noremap = true })

vim.opt.clipboard = vim.opt.clipboard + "unnamedplus"
vim.opt.expandtab = true
vim.opt.foldenable = true
vim.opt.foldlevelstart = 99
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.nu = true
vim.opt.scrolloff = 8
vim.opt.shell = "/opt/homebrew/bin/zsh"
vim.opt.shiftwidth = 2
vim.opt.signcolumn = "yes"
vim.opt.smartindent = false
vim.opt.softtabstop = 2
vim.opt.tabstop = 2
vim.opt.termguicolors = true
vim.opt.updatetime = 100

vim.wo.wrap = false

vim.api.nvim_create_autocmd("TermOpen", {
	pattern = "*",
	command = "setlocal nonumber",
})

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	command = [[%s/\s\+$//e]],
})

-- Close the quickfix menu after selecting choice
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "qf" },
	command = [[nnoremap <buffer> <CR> <CR>:cclose<CR>]],
})

-------------------------------------------------------------------------------
-- Git
-------------------------------------------------------------------------------

local gitportal = require("gitportal")

gitportal.setup({
	always_include_current_line = true,
})

vim.keymap.set("v", "<leader>GP", gitportal.open_file_in_browser)

require("gitsigns").setup()

vim.keymap.set("n", "<C-b>", "<CMD>Git blame<CR>")

-------------------------------------------------------------------------------
-- Colorscheme
-------------------------------------------------------------------------------

vim.cmd.colorscheme("nord")

-------------------------------------------------------------------------------
-- Virtual columns
-------------------------------------------------------------------------------

require("virt-column").setup({
	virtcolumn = "80,120",
})

-------------------------------------------------------------------------------
-- Telescope
-------------------------------------------------------------------------------

local telescope = require("telescope")
local actions = require("telescope.actions")
local telescopeConfig = require("telescope.config")

local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }
table.insert(vimgrep_arguments, "--smart-case")

telescope.setup({
	defaults = {
		vimgrep_arguments = vimgrep_arguments,
	},
	pickers = {
		oldfiles = {
			mappings = {
				i = {
					["<M-BS>"] = function()
						vim.api.nvim_input("<C-w>")
					end,
					["<Tab>"] = actions.move_selection_worse,
					["<S-Tab>"] = actions.move_selection_better,
					["<Esc>"] = actions.close,
				},
			},
		},
		find_files = {
			hidden = true,
			mappings = {
				i = {
					["<M-BS>"] = function()
						vim.api.nvim_input("<C-w>")
					end,
					["<Tab>"] = actions.move_selection_worse,
					["<S-Tab>"] = actions.move_selection_better,
					["<Esc>"] = actions.close,
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
			mappings = { -- extend mappings
				i = {
					["<C-space>"] = actions.to_fuzzy_refine,
				},
			},
		},
	},
})

local builtin = require("telescope.builtin")
local ivy = require("telescope.themes").get_ivy()

vim.keymap.set("n", "<leader>f", function()
	builtin.find_files(ivy)
end, {})
vim.keymap.set("n", "<leader>g", function()
	require("telescope").extensions.live_grep_args.live_grep_args(ivy)
end, {})
vim.keymap.set("n", "<leader>r", function()
	local opts = require("telescope.themes").get_ivy({
		only_cwd = true,
	})
	builtin.oldfiles(opts)
end, {})

telescope.load_extension("fzf")
telescope.load_extension("live_grep_args")

-------------------------------------------------------------------------------
-- Surround
-------------------------------------------------------------------------------

require("nvim-surround").setup({})

-------------------------------------------------------------------------------
-- Folding
-------------------------------------------------------------------------------

vim.o.foldcolumn = "1"
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true

require("ufo").setup({
	provider_selector = function(bufnr, filetype, buftype)
		return { "treesitter" }
	end,
})

-------------------------------------------------------------------------------
-- Comment
-------------------------------------------------------------------------------

require("Comment").setup({
	toggler = {
		line = "<leader>/",
	},
	opleader = {
		line = "<leader>/",
	},
})

-------------------------------------------------------------------------------
-- Oil
-------------------------------------------------------------------------------

require("oil").setup({
	skip_confirm_for_simple_edits = true,
})

vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-------------------------------------------------------------------------------
-- Conform
-------------------------------------------------------------------------------

require("conform").setup({
	mode = "normal",
	formatters_by_ft = {
		elixir = { "mix format" },
		lua = { "stylua" },
		typescript = { "prettier" },
		javascript = { "prettier" },
		json = { "prettier" },
	},
	format_on_save = {
		timeout_ms = 500,
		lsp_format = "fallback",
	},
})

-------------------------------------------------------------------------------
-- Treesitter
-------------------------------------------------------------------------------

vim.api.nvim_set_hl(0, "TSDefinitionUsage", { bg = "#414c60" })
vim.api.nvim_set_hl(0, "TSDefinition", { bg = "#414c60" })

require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"c",
		"elixir",
		"go",
		"javascript",
		"json",
		"lua",
		"markdown",
		"markdown_inline",
		"query",
		"rust",
		"sql",
		"typescript",
		"vim",
		"vimdoc",
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
		},
	},
	indent = { enable = true },
	refactor = {
		highlight_definitions = {
			enable = true,
			clear_on_cursor_move = false,
		},
	},
})

-------------------------------------------------------------------------------
-- LSP
-------------------------------------------------------------------------------

require("trouble").setup()

local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local cmp = require("cmp")

local cmp_next = function(fallback)
	if cmp.visible() then
		cmp.select_next_item()
	else
		fallback()
	end
end

local cmp_prev = function(fallback)
	if cmp.visible() then
		cmp.select_prev_item()
	else
		fallback()
	end
end

local custom_mappings = {
	["<CR>"] = cmp.mapping.confirm({ select = true }),
	["<Tab>"] = cmp_next,
	["<S-Tab>"] = cmp_prev,
	["<C-n>"] = cmp_next,
	["<C-p>"] = cmp_prev,
	["<Down>"] = cmp_next,
	["<Up>"] = cmp_prev,
}

cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

require("copilot").setup({
	suggestion = { enabled = false },
	panel = { enabled = false },
})

require("copilot_cmp").setup()

local lspkind = require("lspkind")

cmp.setup({
	sources = {
		{ name = "nvim_lsp" },
		{ name = "copilot" },
		{ name = "path" },
		{ name = "buffer", keyword_length = 5 },
	},
	formatting = {
		format = lspkind.cmp_format({
			mode = "symbol_text", -- show only symbol annotations
			symbol_map = { Copilot = "" },
			menu = {
				buffer = "[buffer]",
				nvim_lsp = "[lsp]",
				path = "[path]",
				copilot = "[copilot]",
			},
		}),
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
			scrollbar = "",
		},
		documentation = {
			border = nil,
			scrollbar = "",
		},
	},
	experimental = {
		ghost_text = true,
	},
})

vim.api.nvim_create_autocmd("LspAttach", {
	desc = "LSP actions",
	callback = function(event)
		local opts = { buffer = event.buf }

		vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
		vim.keymap.set("n", "gd", builtin.lsp_definitions, opts)
		vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
		vim.keymap.set("n", "gi", builtin.lsp_implementations, opts)
		vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
		vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
		vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
		vim.keymap.set("n", "gR", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
		vim.keymap.set("n", "gf", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", opts)
		vim.keymap.set("n", "<M-Enter>", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
	end,
})

local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()
local border = "single"

lspconfig.lua_ls.setup({
	cmd = { "/opt/homebrew/bin/lua-language-server" },
	capabilities = capabilities,
	handlers = {
		["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
		["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
	},
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
		},
	},
})

lspconfig.ts_ls.setup({
	cmd = { "/opt/homebrew/bin/typescript-language-server", "--stdio" },
	capabilities = capabilities,
	handlers = {
		["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
		["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
	},
	settings = {
		diagnostics = {
			enable = true,
		},
	},
})

lspconfig.eslint.setup({
	flags = {
		allow_incremental_sync = false,
		debounce_text_changes = 1000,
	},
})

lspconfig.elixirls.setup({
	cmd = { "/opt/homebrew/bin/elixir-ls" },
	capabilities = capabilities,
	handlers = {
		["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
		["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
	},
	settings = {
		elixirLS = {
			dialyzerEnabled = false,
			fetchDeps = false,
		},
	},
})

vim.keymap.set("n", "<leader>dn", vim.diagnostic.goto_next)
vim.keymap.set("n", "<leader>dp", vim.diagnostic.goto_prev)

vim.api.nvim_set_hl(0, "LspDiagnosticsUnderlineError", { undercurl = true, fg = "#bf616a", sp = "#bf616a" })
vim.api.nvim_set_hl(0, "LspDiagnosticsUnderlineWarning", { undercurl = true, fg = "#bf616a", sp = "#bf616a" })
