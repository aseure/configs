return {
	"folke/flash.nvim",
	event = "VeryLazy",
	---@type Flash.Config
	opts = {},
	keys = {
		{
			"<leader>/",
			mode = { "n", "x", "o" },
			function()
				require("flash").jump()
			end,
			desc = "Flash",
		},
	},
}
