return {
	{
		"projekt0n/github-nvim-theme",
		config = function()
			require("github-theme").setup({
				options = {
					styles = {
						strings = "italic",
						functions = "bold",
					},
				},
			})
			vim.cmd("colorscheme github_dark_default")
		end,
	},
}
