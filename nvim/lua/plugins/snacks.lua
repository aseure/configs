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
			layout = {
				preset = "vertical",
			},
		},
		git = {
			enabled = true,
		},
	},
	keys = function()
		config = {
			matcher = { frecency = true },
		}

		return {
			{
				"<leader>ff",
				function()
					Snacks.picker.files(config)
				end,
			},
			{
				"<leader>fp",
				function()
					Snacks.picker.projects(config)
				end,
			},
			{
				"<leader>fr",
				function()
					Snacks.picker.recent(config)
				end,
			},
			{
				"<leader>fg",
				function()
					Snacks.picker.grep(config)
				end,
			},
			{
				"<leader>fw",
				function()
					Snacks.picker.grep_word(config)
				end,
			},
			{
				"<leader>fs",
				function()
					Snacks.picker.lsp_symbols(config)
				end,
			},
			{
				"grr",
				function()
					Snacks.picker.lsp_references(config)
				end,
			},
		}
	end,
}
