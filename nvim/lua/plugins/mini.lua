return {
	"echasnovski/mini.nvim",
	lazy = false,
	version = false,
	config = function()
		require("mini.comment").setup()
		require("mini.move").setup({
			mappings = {
				up = "<A-S-Up>",
				down = "<A-S-Down>",
			},
		})
	end,
}
