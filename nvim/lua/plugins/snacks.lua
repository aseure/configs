return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		statuscolumn = {
			enabled = true,
		},
		explorer = {
			enabled = true,
		},
		indent = {
			enabled = true,
			animate = {
				enabled = false,
			},
		},
		picker = {
			enabled = true,
		},
		git = {
			enabled = true,
		},
	},
	keys = function()
		config = {
			layout = { preset = "bottom" },
		}

		return {
			{
				"<leader>f",
				function()
					Snacks.picker.files(config)
				end,
			},
			{
				"<leader>b",
				function()
					Snacks.picker.buffers(config)
				end,
			},
			{
				"<leader>r",
				function()
					Snacks.picker.recent(config)
				end,
			},
			{
				"<leader>g",
				function()
					Snacks.picker.grep(config)
				end,
			},
			{
				"<leader>w",
				function()
					Snacks.picker.grep_word(config)
				end,
			},
		}
	end,
}

