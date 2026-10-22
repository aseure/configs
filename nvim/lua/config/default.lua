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
vim.keymap.set("n", "<A-h>", "<C-w>h", { desc = "Focus left window" })
vim.keymap.set("n", "<A-t>", "<C-w>j", { desc = "Focus left window" })
vim.keymap.set("n", "<A-n>", "<C-w>k", { desc = "Focus left window" })
vim.keymap.set("n", "<A-s>", "<C-w>l", { desc = "Focus left window" })

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
vim.opt.undofile = true
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

local function is_treesitter_ignored_language(lang)
	local ignored_languages = {
		"blink-cmp*",
		"conform-info",
		"env",
		"flash_prompt",
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
		vim.treesitter.start()
	end,
})
