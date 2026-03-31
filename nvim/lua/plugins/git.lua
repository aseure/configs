return {
	{
		"lewis6991/gitsigns.nvim",
		lazy = false,
		opts = {
			signcolumn = false,
		},
		keys = {
			{
				"<leader>gb",
				function()
					require("gitsigns").blame()
				end,
			},
		},
	},
	{
		"trevorhauter/gitportal.nvim",
		url = "https://codeberg.org/trevorhauter/gitportal.nvim",
		lazy = false,
		opts = {
			always_include_current_line = true,
		},
		keys = {
			{
				"<leader>go",
				function()
					require("gitportal").open_file_in_browser()
				end,
				mode = { "n", "v" },
			},
		},
	},
	{
		"sindrets/diffview.nvim",
		lazy = false,
		opts = {},
		keys = {
			{
				"<leader>gg",
				function()
					local lib = require("diffview.lib")
					if lib.get_current_view() then
						vim.cmd("DiffviewClose")
					else
						vim.cmd("DiffviewOpen")
					end
				end,
				desc = "Toggle DiffView",
			},
			{
				"<leader>gf",
				"<CMD>DiffviewFileHistory %<CR>",
				desc = "File git history",
			},
		},
	},
}
