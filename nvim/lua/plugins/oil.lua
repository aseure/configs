return {
	{
		"stevearc/oil.nvim",
		opts = {
			skip_confirm_for_simple_edits = true,
		},
		keys = {
			{ "-", "<CMD>Oil<CR>", desc = "Open parent directory" },
		},
		lazy = false,
	},
}
