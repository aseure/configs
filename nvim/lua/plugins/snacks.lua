return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		statuscolumn = {
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
			layout = {
				preset = "vertical",
				layout = {
					width = 0.9,
				},
			},
		},
		git = {
			enabled = true,
		},
	},
	keys = function()
		return {
			{
				"<leader>ff",
				function()
					Snacks.picker.smart({
						matcher = { frecency = true },
						formatters = {
							file = {
								truncate = 120,
							},
						},
					})
				end,
			},
			{
				"<leader>fg",
				function()
					Snacks.picker.grep({
						matcher = { frecency = true },
						formatters = {
							file = {
								truncate = 120,
							},
						},
					})
				end,
			},
			{
				"<leader>fw",
				function()
					Snacks.picker.grep_word({
						matcher = { frecency = true },
					})
				end,
			},
			{
				"<leader>fb",
				function()
					Snacks.picker.buffers({
						matcher = { frecency = true },
					})
				end,
			},
			{
				"<leader>fs",
				function()
					Snacks.picker.lsp_symbols({
						matcher = { frecency = true },
					})
				end,
			},
			{
				"grr",
				function()
					Snacks.picker.lsp_references({
						matcher = { frecency = true },
					})
				end,
			},
		}
	end,
}
