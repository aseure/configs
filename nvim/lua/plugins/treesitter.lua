return {
	{
		"nvim-treesitter/nvim-treesitter",
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
				refactor = {
					highlight_definitions = {
						enable = true,
						clear_on_cursor_move = false,
					},
				},
			})
		end,
	},
	{
		{ "nvim-treesitter/nvim-treesitter-refactor" },
	},
}
