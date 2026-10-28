if vim.g.loaded_commit_diff then
	return
end
vim.g.loaded_commit_diff = true

vim.api.nvim_create_user_command("CommitDiff", function(opts)
	require("commit-diff").run(opts.fargs)
end, { nargs = "*", desc = "Open the changes a commit made to some of its files, side by side" })
