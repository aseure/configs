return {
	"echasnovski/mini.nvim",
	lazy = false,
	version = false,
	config = function()
		require("mini.ai").setup()
		require("mini.comment").setup()
		require("mini.operators").setup()
		require("mini.surround").setup()
		require("mini.bracketed").setup()
		require("mini.extra").setup()
		require("mini.pick").setup()
		require("mini.cursorword").setup()
		require("mini.hipatterns").setup()
	end,
	keys = {
		{
			"<leader>ff",
			function()
				require("mini.pick").builtin.files()
			end,
		},
		{
			"<leader>fg",
			function()
				require("mini.pick").builtin.grep_live()
			end,
		},
	},
}
