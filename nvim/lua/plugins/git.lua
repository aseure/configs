return {
	{
		"lewis6991/gitsigns.nvim",
		lazy = false,
		opts = {},
	},
	{
		"sindrets/diffview.nvim",
		cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
	},
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"sindrets/diffview.nvim",
			"folke/snacks.nvim",
		},
		opts = {
			integrations = { diffview = true },
		},
		keys = {
			{
				"<leader>gs",
				mode = { "n" },
				function()
					require("neogit").open({ kind = "split" })
				end,
				desc = "Open Neogit in split",
			},
		},
	},
}
