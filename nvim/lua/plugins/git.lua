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
		opts = {
			always_include_current_line = true,
		},
		keys = {
			{
				"<leader>go",
				function()
					require("gitportal").to_remote()
				end,
				mode = { "n", "v" },
			},
		},
	},
}
