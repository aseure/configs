-- Define leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

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

-- Quickfix helpers
local function is_qf_open()
	for _, win in pairs(vim.fn.getwininfo()) do
		if win["quickfix"] == 1 then
			return true
		end
	end
	return false
end

local function is_qf_empty()
	return #vim.fn.getqflist() == 0
end

-- Toggle quickfix list
local function toggle_quickfix()
	if is_qf_open() then
		vim.cmd("cclose")
	else
		vim.cmd("copen")
	end
end
vim.keymap.set("n", "<leader>q", toggle_quickfix, { desc = "Toggle quickfix list" })

-- Navigate quickfix list
local function qf_navigate(direction)
	if is_qf_empty() then
		return
	end

	if not is_qf_open() then
		vim.cmd("copen")
	end

	pcall(vim.cmd, direction)
end

vim.keymap.set("n", "<A-Down>", function()
	qf_navigate("cnext")
end, { desc = "Next quickfix item" })

vim.keymap.set("n", "<A-Up>", function()
	qf_navigate("cprev")
end, { desc = "Previous quickfix item" })

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

-- Close the quickfix menu after selecting choice
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "qf" },
	command = [[nnoremap <buffer> <CR> <CR>:cclose<CR>]],
})

-- Enable treesitter highlighting for all filetypes with an installed parser
local ignore_list_treesitter_filetypes = {
	"blink-cmp-menu",
	"fzf",
	"oil",
}

vim.api.nvim_create_autocmd("FileType", {
	callback = function(args)
		if vim.tbl_contains(ignore_list_treesitter_filetypes, args.match) then
			return
		end
		vim.treesitter.start()
	end,
})
