return {
	"folke/flash.nvim",
	event = "VeryLazy",
	opts = {},
	-- stylua: ignore
	keys = {
	  { "/", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
	},
}
