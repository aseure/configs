local function toggle_flag(flag)
	local state = require("grug-far").get_instance(0):toggle_flags({ flag })[1]
	vim.notify("grug-far: " .. flag .. " " .. (state and "ON" or "OFF"))
end

local function set_flag_toggle_keymaps()
	vim.keymap.set({ "n", "i" }, "<M-f>", function()
		toggle_flag("--fixed-strings")
	end, { buffer = true, desc = "grug-far: Toggle exact matching" })
	vim.keymap.set({ "n", "i" }, "<M-h>", function()
		toggle_flag("--hidden")
	end, { buffer = true, desc = "grug-far: Toggle hidden files" })
end

return {
	"MagicDuck/grug-far.nvim",
	config = function()
		require("grug-far").setup({
			windowCreationCommand = "lua local w, h = math.floor(vim.o.columns * 0.8), math.floor(vim.o.lines * 0.8); "
				.. "vim.api.nvim_open_win(0, true, { relative = 'editor', width = w, height = h, "
				.. "col = math.floor((vim.o.columns - w) / 2), row = math.floor((vim.o.lines - h) / 2), border = 'rounded' })",
			keymaps = {
				close = { n = "<Esc>" },
				nextInput = { n = "<Tab>", i = "<Tab>" },
				prevInput = { n = "<S-Tab>", i = "<S-Tab>" },
			},
		})

		vim.api.nvim_create_autocmd("FileType", {
			group = vim.api.nvim_create_augroup("grug-far-keybindings", { clear = true }),
			pattern = "grug-far",
			callback = set_flag_toggle_keymaps,
		})
	end,
	keys = {
		{ "<leader>sr", "<CMD>GrugFar<CR>", desc = "Open find and replace" },
		{
			"<leader>sr",
			function()
				require("grug-far").with_visual_selection()
			end,
			mode = "x",
			desc = "Find and replace the selection",
		},
		{
			"<leader>sw",
			function()
				require("grug-far").open({ prefills = { search = vim.fn.expand("<cword>") } })
			end,
			desc = "Find and replace the word under cursor",
		},
		{
			"<leader>sf",
			function()
				require("grug-far").open({ prefills = { paths = vim.fn.expand("%") } })
			end,
			desc = "Find and replace in the current file",
		},
		{ "<leader>sv", ":GrugFarWithin<CR>", mode = "x", desc = "Find and replace within the selected lines" },
		{
			"<leader>sa",
			function()
				require("grug-far").open({ engine = "astgrep" })
			end,
			desc = "Find and replace with ast-grep",
		},
	},
}
