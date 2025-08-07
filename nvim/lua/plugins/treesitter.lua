return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "master",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"bash",
					"c",
					"elixir",
					"go",
					"javascript",
					"json",
					"lua",
					"markdown",
					"markdown_inline",
					"python",
					"query",
					"rust",
					"sql",
					"typescript",
					"vim",
					"vimdoc",
				},
				sync_install = false,
				auto_install = true,
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},
				incremental_selection = {
					enable = true,
					keymaps = {
						node_incremental = "v",
						node_decremental = "V",
					},
				},
				indent = { enable = true },
			})
		end,
	},
	{
		"CKolkey/ts-node-action",
		dependencies = { "nvim-treesitter" },
		config = true,
		keys = {
			{
				"ga",
				function()
					require("ts-node-action").node_action()
				end,
				desc = "Node Action",
			},
		},
	},
}
