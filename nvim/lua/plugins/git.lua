return {
	{
		"lewis6991/gitsigns.nvim",
		lazy = false,
		opts = {},
		keys = {
			{
				"<leader>gb",
				function()
					require("gitsigns").blame()
				end,
			},
			{
				"<leader>gd",
				function()
					if vim.wo.diff then
						for _, win in ipairs(vim.api.nvim_list_wins()) do
							local buf = vim.api.nvim_win_get_buf(win)
							if vim.api.nvim_buf_get_name(buf):match("^gitsigns://") then
								vim.api.nvim_win_close(win, false)
								return
							end
						end
					else
						require("gitsigns").diffthis()
					end
				end,
			},
		},
	},
	{
		"trevorhauter/gitportal.nvim",
		url = "https://codeberg.org/trevorhauter/gitportal.nvim",
		lazy = false,
		opts = {
			always_include_current_line = true,
		},
		keys = {
			{
				"<leader>go",
				function()
					require("gitportal").open_file_in_browser()
				end,
				mode = { "n", "v" },
			},
		},
	},
}
