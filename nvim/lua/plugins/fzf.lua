return {
	"ibhagwan/fzf-lua",
	dependencies = { "nvim-mini/mini.icons" },
	config = function()
		require("fzf-lua").setup({
			winopts = {
				preview = {
					layout = "vertical",
				},
			},
			fzf_colors = { false },
		})
		require("fzf-lua").register_ui_select()
	end,
	keys = {
		{
			"<leader>ff",
			function()
				require("fzf-lua").files()
			end,
		},
		{
			"<leader>fg",
			function()
				require("fzf-lua").live_grep()
			end,
		},
		{
			"<leader>fw",
			function()
				require("fzf-lua").grep_cword()
			end,
		},
		{
			"<leader>fb",
			function()
				require("fzf-lua").buffers()
			end,
		},
	},
}
