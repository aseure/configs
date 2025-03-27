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
	{ "lukas-reineke/virt-column.nvim" },
	{ "shaunsingh/nord.nvim" },
	-- Navigation
	{ "stevearc/oil.nvim" },
	{ "folke/snacks.nvim" },
	-- Editing
	{ "kylechui/nvim-surround", version = "*", event = "VeryLazy" },
	{ "numToStr/Comment.nvim" },
	{ "stevearc/conform.nvim" },
	{ "windwp/nvim-autopairs", event = "InsertEnter", config = true },
	-- Tree-sitter
	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
	{ "nvim-treesitter/nvim-treesitter-refactor" },
	-- Testing
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
	},
	{ "jfpedroza/neotest-elixir" },
	{ "nvim-neotest/neotest-jest" },
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
vim.opt.cursorline = true

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

function is_first_quickfix_entry()
	local cur_idx = vim.fn.getqflist({ idx = 0 }).idx
	return cur_idx == 1
end

function is_last_quickfix_entry()
	local qflist = vim.fn.getqflist()
	local cur_idx = vim.fn.getqflist({ idx = 0 }).idx
	return cur_idx == #qflist
end

vim.keymap.set("n", "<S-A-Up>", function()
	vim.cmd("copen")
	vim.cmd("cfirst")
end)

vim.keymap.set("n", "<A-Up>", function()
	vim.cmd("copen")
	if not is_first_quickfix_entry() then
		vim.cmd("cprev")
	end
end)

vim.keymap.set("n", "<A-Down>", function()
	vim.cmd("copen")
	if not is_last_quickfix_entry() then
		vim.cmd("cnext")
	end
end)

vim.keymap.set("n", "<S-A-Down>", function()
	vim.cmd("copen")
	vim.cmd("clast")
end)

-------------------------------------------------------------------------------
-- Git
-------------------------------------------------------------------------------

local gitportal = require("gitportal")

gitportal.setup({
	always_include_current_line = true,
})

require("gitsigns").setup()

vim.keymap.set({ "n", "v" }, "<C-g>o", gitportal.open_file_in_browser)
vim.keymap.set("n", "<leader>hb", "<cmd>Gitsigns blame<CR>")
vim.keymap.set("n", "<leader>hd", "<cmd>Gitsigns toggle_deleted<CR>")
vim.keymap.set("n", "<leader>hr", "<cmd>Gitsigns reset_hunk<CR>")
vim.keymap.set("n", "<leader>hq", "<cmd>Gitsigns setqflist<CR>")

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
-- Navigation
-------------------------------------------------------------------------------

-- Search for visual selection
-- <leader>r to search recent files
-- <leader>f to search files
-- <leader>b to search buffers
-- <leader>g to grep
-- grep in hidden files (i.e. .github/ directory)
-- grep by filetype
-- grep by directory
-- grep by word boundary (\b)
--
local snacks = require("snacks")

snacks.setup({
	explorer = {
		enabled = true,
	},
	indent = {
		enabled = true,
		animate = {
			duration = {
				step = 50, -- ms per step
				total = 250, -- maximum duration
			},
		},
	},
	picker = {
		enabled = true,
	},
})

vim.keymap.set("n", "<leader>f", function()
	snacks.picker.explorer({
		auto_close = true,
		focus = "input",
		layout = { preset = "vertical" },
		jump = { close = true },
	})
end)

vim.keymap.set("n", "<leader>b", function()
	snacks.picker.buffers({
		layout = { preset = "vertical" },
	})
end)

vim.keymap.set("n", "<leader>r", function()
	snacks.picker.recent({
		layout = { preset = "vertical" },
	})
end)

vim.keymap.set("n", "<leader>g", function()
	snacks.picker.grep({
		layout = { preset = "vertical" },
		toggles = {
			hidden = "h",
			fixed_string = "f",
		},
	})
end)

-------------------------------------------------------------------------------
-- Surround
-------------------------------------------------------------------------------

require("nvim-surround").setup({})

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
		bash = { "shfmt" },
		elixir = { "mix" },
		javascript = { "prettier" },
		json = { "prettier" },
		lua = { "stylua" },
		python = { "isort", "black" },
		typescript = { "prettier" },
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
		"bash",
		"c",
		"elixir",
		"go",
		"javascript",
		"json",
		"lua",
		"lua",
		"markdown",
		"markdown_inline",
		"python",
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
			node_incremental = "v",
			node_decremental = "V",
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
-- Testing
-------------------------------------------------------------------------------

require("neotest").setup({
	adapters = {
		require("neotest-elixir"),
		require("neotest-jest")({
			jestCommand = "npx jest ",
		}),
	},
})

vim.keymap.set("n", "<leader>tt", function()
	require("neotest").run.run()
end)

vim.keymap.set("n", "<leader>ta", function()
	require("neotest").run.run(vim.fn.expand("%"))
end)

vim.keymap.set("n", "<leader>to", function()
	require("neotest").output.open({ enter = true, auto_close = true })
end)

-------------------------------------------------------------------------------
-- LSP
-------------------------------------------------------------------------------

local trouble = require("trouble")

trouble.setup({
	modes = {
		diagnostics = {
			sort = { "filename", "pos", "severity", "message" },
		},
	},
})

vim.keymap.set("n", "<S-A-t>", function()
	trouble.prev({ jump = true })
end)

vim.keymap.set("n", "<A-t>", function()
	trouble.next({ jump = true })
end)

vim.keymap.set("n", "<A-d>", function()
	vim.cmd("Trouble diagnostics open filter = {buf = 0}")
	trouble.next({ jump = true })
end)

vim.keymap.set("n", "<S-A-d>", function()
	vim.cmd("Trouble diagnostics open filter = {buf = 0}")
	trouble.prev({ jump = true })
end)

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
		vim.keymap.set("n", "gd", snacks.picker.lsp_definitions, opts)
		vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
		vim.keymap.set("n", "gi", snacks.picker.lsp_implementations, opts)
		vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
		vim.keymap.set("n", "gr", snacks.picker.lsp_references, opts)
		vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
		vim.keymap.set("n", "gR", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
		vim.keymap.set("n", "gf", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", opts)
		vim.keymap.set("n", "<M-Enter>", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
	end,
})

local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()
local handlers = {
	["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
	["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
}

lspconfig.lua_ls.setup({
	cmd = { "/opt/homebrew/bin/lua-language-server" },
	capabilities = capabilities,
	handlers = handlers,
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
	handlers = handlers,
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
	handlers = handlers,
	settings = {
		elixirLS = {
			dialyzerEnabled = false,
			fetchDeps = false,
		},
	},
})

lspconfig.pyright.setup({
	cmd = { "/opt/homebrew/bin/pyright-langserver", "--stdio" },
	capabilities = capabilities,
	handlers = handlers,
})

lspconfig.bashls.setup({
	cmd = { "/opt/homebrew/bin/bash-language-server", "start" },
	capabilities = capabilities,
	handlers = handlers,
})

vim.diagnostic.config({
	virtual_lines = false,
	virtual_text = false,
	float = {
		border = "rounded",
	},
})

local red_undercurl = { undercurl = true, fg = "#bf616a", sp = "#bf616a" }
vim.api.nvim_set_hl(0, "LspDiagnosticsUnderlineError", red_undercurl)
vim.api.nvim_set_hl(0, "LspDiagnosticsUnderlineWarning", red_undercurl)
vim.api.nvim_set_hl(0, "DiagnosticUnnecessary", red_undercurl)
