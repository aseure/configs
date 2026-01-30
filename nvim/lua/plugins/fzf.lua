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
			keymap = {
				fzf = {
					["ctrl-q"] = "select-all+accept",
				},
			},
			grep = {
				rg_opts = "--hidden --column --line-number --no-heading --color=always --smart-case --max-columns=4096 -e",
			},
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
				require("fzf-lua").live_grep_native()
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
