return {
	"folke/trouble.nvim",
	cmd = "Trouble",
	config = function()
		require("trouble").setup({
			auto_close = true,
			auto_jump = true,
			focus = true,
		})

		local red_undercurl = { undercurl = true, fg = "#bf616a", sp = "#bf616a" }
		vim.api.nvim_set_hl(0, "LspDiagnosticsUnderlineError", red_undercurl)
		vim.api.nvim_set_hl(0, "LspDiagnosticsUnderlineWarning", red_undercurl)
	end,
	keys = {
		{
			"<leader>xx",
			"<cmd>Trouble diagnostics toggle win.position=bottom<cr>",
			desc = "Diagnostics",
		},
		{
			"<leader>xs",
			"<cmd>Trouble symbols toggle win.position=bottom<cr>",
			desc = "Symbols",
		},
	},
}
