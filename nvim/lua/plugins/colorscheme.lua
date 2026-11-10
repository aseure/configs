return {
	{
		"blazkowolf/gruber-darker.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("gruber-darker").setup({
				italic = {
					strings = false,
					comments = false,
					operators = false,
					folds = false,
				},
			})
			vim.cmd.colorscheme("gruber-darker")
		end,
	},
}
