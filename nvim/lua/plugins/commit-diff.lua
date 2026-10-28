return {
	dir = vim.fn.stdpath("config") .. "/local/commit-diff",
	name = "commit-diff",
	dependencies = { "ibhagwan/fzf-lua" },
	cmd = "CommitDiff",
	keys = {
		{ "<leader>gc", "<CMD>CommitDiff<CR>", desc = "Open file changes from a commit" },
	},
}
