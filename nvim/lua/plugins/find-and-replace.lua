return {
	"MagicDuck/grug-far.nvim",
	config = function()
		require("grug-far").setup({})
	end,
	keys = {
		{ "<leader>G", "<CMD>GrugFar<CR>", desc = "Open find and replace" },
	},
}
