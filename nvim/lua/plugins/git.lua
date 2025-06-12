return {
	"lewis6991/gitsigns.nvim",
	lazy = false,
	opts = {},
	keys = {
		{ "<leader>gd", "<cmd>Gitsigns preview_hunk_inline<CR>" },
		{ "<leader>gr", "<cmd>Gitsigns reset_hunk<CR>" },
	},
	{
		"tpope/vim-fugitive",
		cmd = { "Git", "G", "GBRowse" },
		keys = {
			{ "<leader>gb", "<cmd>Git blame<CR>" },
		},
	},
	{
		"tpope/vim-rhubarb",
		dependencies = { "tpope/vim-fugitive" },
		lazy = true,
		keys = {
			{ "<leader>go", "<cmd>GBrowse<CR>", mode = { "n", "v" } },
		},
	},
}
