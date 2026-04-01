return {
	{
		"nvim.undotree",
		dir = vim.env.VIMRUNTIME .. "/pack/dist/opt/nvim.undotree",
		keys = {
			{ "<leader>u", function() require("undotree").open({ command = "botright 30vnew" }) end, desc = "Open Undo tree" },
		},
	},
}
