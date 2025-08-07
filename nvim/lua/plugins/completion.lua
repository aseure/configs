return {
	{
		"github/copilot.vim",
		cmd = "Copilot",
		event = "BufWinEnter",
		init = function()
			vim.g.copilot_no_maps = true
		end,
		config = function()
			-- Block the normal Copilot suggestions
			vim.api.nvim_create_augroup("github_copilot", { clear = true })
			vim.api.nvim_create_autocmd({ "FileType", "BufUnload" }, {
				group = "github_copilot",
				callback = function(args)
					vim.fn["copilot#On" .. args.event]()
				end,
			})
			vim.fn["copilot#OnFileType"]()
		end,
	},
	{
		"saghen/blink.cmp",
		dependencies = {
			"fang2hou/blink-copilot",
			"rafamadriz/friendly-snippets",
		},
		version = "1.*",
		opts = {
			keymap = {
				preset = "none",
				["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
				["<CR>"] = { "accept", "fallback" },
				["<Tab>"] = { "select_next", "fallback_to_mappings" },
				["<S-Tab>"] = { "select_prev", "fallback_to_mappings" },
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
					show_with_menu = false,
				},
				trigger = {
					show_in_snippet = false,
				},
			},
			sources = {
				default = { "lsp", "copilot", "snippets", "path", "buffer" },
				providers = {
					copilot = {
						name = "copilot",
						module = "blink-copilot",
						score_offset = 100,
						async = true,
					},
				},
			},
		},
	},
}
