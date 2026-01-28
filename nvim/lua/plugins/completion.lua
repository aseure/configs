return {
	{
		"saghen/blink.cmp",
		dependencies = {
			"rafamadriz/friendly-snippets",
		},
		version = "1.*",
		opts = {
			keymap = {
				preset = "none",
				["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
				["<CR>"] = { "accept", "fallback" },
				["<Tab>"] = { "accept", "fallback" },
				["<C-n>"] = { "select_next", "fallback_to_mappings" },
				["<C-p>"] = { "select_prev", "fallback_to_mappings" },
			},
			signature = {
				enabled = true,
			},
			completion = {
				list = {
					selection = {
						preselect = true,
						auto_insert = true,
					},
				},
				menu = {
					draw = {
						treesitter = { "lsp" },
						columns = {
							{ "kind_icon", "label", "label_description", gap = 1 },
							{ "kind" },
						},
					},
				},
				documentation = {
					auto_show = false,
					auto_show_delay_ms = 100,
				},
				ghost_text = {
					enabled = true,
					show_with_menu = true,
				},
				trigger = {
					show_in_snippet = false,
				},
			},
			sources = {
				default = { "lsp", "snippets", "path", "buffer" },
			},
		},
	},
}
