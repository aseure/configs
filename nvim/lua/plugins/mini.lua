return {
	"echasnovski/mini.nvim",
	lazy = false,
	version = false,
	config = function()
		require("mini.ai").setup()
		require("mini.comment").setup()
		require("mini.cursorword").setup()
		require("mini.diff").setup()
		require("mini.extra").setup()
		require("mini.hipatterns").setup()
		require("mini.indentscope").setup({
			draw = {
				delay = 0,
				animation = function()
					return 0
				end,
			},
			options = {
				try_as_border = true,
			},
			symbol = "│",
		})
		require("mini.surround").setup()
	end,
	keys = {
		{
			"<leader>gd",
			function()
				require("mini.diff").toggle_overlay()
			end,
		},
	},
}
