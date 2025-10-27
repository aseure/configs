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
		},
	},
	{
		"trevorhauter/gitportal.nvim",
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
	{
		"tpope/vim-fugitive",
		lazy = false,
		config = function()
			-- Function to get list of git branches for completion
			local function get_branches()
				local branches = vim.fn.systemlist('git branch --all --format="%(refname:short)"')
				return branches
			end

			-- Create command with branch completion
			vim.api.nvim_create_user_command("GitLog", function(opts)
				vim.cmd("Git log --oneline --graph --decorate " .. opts.args)
			end, {
				nargs = 1,
				complete = function()
					return get_branches()
				end,
				desc = "Git log for specified branch",
			})
		end,
		keys = {
			{ "<leader>gd", ":Gvdiffsplit<CR>", desc = "Git diff split" },
			{ "<leader>gg", ":Git<CR>", desc = "Git status" },
			{ "<leader>gl", ":GitLog HEAD<CR>", desc = "Git log" },
			{ "<leader>gL", ":GitLog ", desc = "Git log (select branch)" },
		},
	},
}
