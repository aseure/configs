return {
	{
		"saghen/blink.cmp",
		dependencies = {
			"rafamadriz/friendly-snippets",
			"milanglacier/minuet-ai.nvim",
		},
		version = "1.*",
		opts = {
			keymap = {
				preset = "none",
				["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
				["<CR>"] = { "accept", "fallback" },
				["<C-n>"] = { "select_next", "fallback_to_mappings" },
				["<C-p>"] = { "select_prev", "fallback_to_mappings" },
				["<Tab>"] = { "select_next", "fallback_to_mappings" },
				["<S-Tab>"] = { "select_prev", "fallback_to_mappings" },
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
					prefetch_on_insert = false,
				},
			},
			sources = {
				default = { "lsp", "minuet", "snippets", "path", "buffer" },
				providers = {
					minuet = {
						name = "minuet",
						module = "minuet.blink",
						async = true,
						timeout_ms = 3000,
						score_offset = 50,
					},
				},
			},
		},
	},
}
