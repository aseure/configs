return {
	{
		"lewis6991/gitsigns.nvim",
		lazy = false,
		opts = {},
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
		"NeogitOrg/neogit",
		lazy = true,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"sindrets/diffview.nvim",
			"ibhagwan/fzf-lua",
		},
		cmd = "Neogit",
		opts = {
			integrations = {
				fzf_lua = true,
			},
		},
		keys = {
			{ "<leader>gg", "<cmd>Neogit<cr>", desc = "Show Neogit UI" },
			{ "<leader>dc", "<cmd>DiffviewClose<cr>", desc = "Close Diffview" },
		},
	},
}
