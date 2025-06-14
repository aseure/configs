return {
	{
		"lewis6991/gitsigns.nvim",
		lazy = false,
		opts = {},
	},
	{
		"tpope/vim-fugitive",
		lazy = false,
		cmd = { "Git", "G", "GBrowse" },
		keys = {
			{ "<leader>gs", "<cmd>Git | only<CR>" },
			{ "<leader>gb", "<cmd>Git blame | only<CR>" },
			{ "<leader>gd", "<cmd>Git diff | only<CR>" },
			{ "<leader>gc", "<cmd>Git diff HEAD | only<CR>" },
			{ "<leader>gl", "<cmd>Git log --graph --oneline --decorate | only<CR>" },
		},
	},
	{
		"tpope/vim-rhubarb",
		dependencies = { "tpope/vim-fugitive" },
		lazy = true,
		keys = {
			{ "<leader>go", "<cmd>GBrowse<CR>", mode = { "n" } },
			{ "<leader>go", ":GBrowse<CR>", mode = { "v" } },
		},
	},
}
