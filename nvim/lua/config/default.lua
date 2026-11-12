-- Define leader key
vim.g.mapleader = " "
vim.g.maplocalleader = ","

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

-- Better window navigation
vim.keymap.set("n", "<C-w>v", "<C-w>v<C-w>l", { desc = "Split window vertically and focus new split" })
vim.keymap.set("n", "<C-w>s", "<C-w>s<C-w>j", { desc = "Split window horizontally and focus new split" })
local in_ghostty = vim.env.TERM_PROGRAM == "ghostty"

local ghostty_tty

local function ghostty_action(action, opts)
	ghostty_tty = ghostty_tty or "/dev/" .. vim.trim(vim.fn.system({ "ps", "-o", "tty=", "-p", tostring(vim.fn.getpid()) }))
	local script = ('tell application "Ghostty" to perform action "%s" on (first terminal whose tty is "%s")'):format(action, ghostty_tty)
	vim.system({ "osascript", "-e", script }, opts)
end

if in_ghostty then
	vim.api.nvim_create_autocmd({ "VimEnter", "VimResume" }, {
		callback = function()
			ghostty_action("activate_key_table:nvim")
		end,
	})
	vim.api.nvim_create_autocmd({ "VimLeavePre", "VimSuspend" }, {
		callback = function()
			ghostty_action("deactivate_key_table", { detach = true })
		end,
	})
end

-- Move to the neighbouring split, or to the neighbouring Ghostty split at the edge
local function focus_window(direction, ghostty_direction)
	local window = vim.api.nvim_get_current_win()
	vim.cmd.wincmd(direction)
	if in_ghostty and window == vim.api.nvim_get_current_win() then
		ghostty_action("goto_split:" .. ghostty_direction)
	end
end

vim.keymap.set("n", "<A-h>", function()
	focus_window("h", "left")
end, { desc = "Focus left window or Ghostty split" })
vim.keymap.set("n", "<A-t>", function()
	focus_window("j", "down")
end, { desc = "Focus lower window or Ghostty split" })
vim.keymap.set("n", "<A-c>", function()
	focus_window("k", "up")
end, { desc = "Focus upper window or Ghostty split" })
vim.keymap.set("n", "<A-n>", function()
	focus_window("l", "right")
end, { desc = "Focus right window or Ghostty split" })

-- Better tab navigation
vim.keymap.set("n", "<C-t>c", ":tabclose<CR>")
vim.keymap.set("n", "<C-t>n", ":tabnew<CR>")

-- Paste in visual mode without overwriting the register with the replaced text
vim.keymap.set("x", "p", '"_dP')

vim.opt.clipboard = vim.opt.clipboard + "unnamedplus"
vim.opt.cursorline = true
vim.opt.expandtab = true
vim.opt.foldenable = true
vim.opt.foldlevelstart = 99
-- foldmethod: compute folds from an expression instead of creating them manually
-- foldexpr: that expression asks Treesitter for foldable nodes (functions, blocks, do...end, etc.)
-- foldtext: show a closed fold as its first line with regular syntax highlighting
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldtext = ""
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
vim.opt.splitkeep = "screen"
vim.opt.tabstop = 2
vim.opt.tags = { "./tags", "tags" }
vim.opt.termguicolors = true
vim.opt.textwidth = 80
vim.opt.undofile = true
vim.opt.updatetime = 100

vim.wo.wrap = false

-- Auto-wrap comments at 'textwidth' while typing, set per buffer since ftplugins override 'formatoptions':
--   c: auto-wrap comments at 'textwidth', inserting the comment leader
--   q: allow formatting comments with gq/gw
--   j: remove the comment leader when joining lines with J
--   removing t: never auto-wrap regular code
vim.api.nvim_create_autocmd("FileType", {
	callback = function()
		vim.opt_local.formatoptions:append("cqj")
		vim.opt_local.formatoptions:remove("t")
	end,
})

vim.api.nvim_create_autocmd("TermOpen", {
	pattern = "*",
	command = "setlocal nonumber",
})

local function is_treesitter_ignored_language(lang)
	local ignored_languages = {
		"blink-cmp*",
		"conform-info",
		"env",
		"fzf",
		"git",
		"gitsigns-blame",
		"grug-far",
		"lazy*",
		"netrc",
		"oil",
		"oil*",
		"qf",
		"smarty",
		"text",
		"zip",
		"conf",
	}
	for _, ignored_lang in pairs(ignored_languages) do
		if lang == ignored_lang then
			return true
		end

		if ignored_lang:sub(-1) == "*" then
			local prefix = ignored_lang:sub(1, -2)
			if lang:sub(1, #prefix) == prefix then
				return true
			end
		end
	end

	return false
end

vim.api.nvim_create_autocmd("FileType", {
	callback = function(args)
		if is_treesitter_ignored_language(args.match) then
			return
		end
		-- Only use treesitter when it can highlight, otherwise keep the built-in syntax highlighting
		local lang = vim.treesitter.language.get_lang(args.match) or args.match
		local ok, query = pcall(vim.treesitter.query.get, lang, "highlights")
		if ok and query then
			vim.treesitter.start()
		end
	end,
})
