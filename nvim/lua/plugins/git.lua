local function pull_request_number_under_cursor()
	return vim.fn.expand("<cWORD>"):match("#(%d+)")
end

local function blame_buffer_gitdir(bufnr)
	return vim.api.nvim_buf_get_name(bufnr):match("^gitsigns%-blame://(.-)//")
end

local function open_pull_request(number, gitdir)
	vim.system({ "gh", "browse", "--no-browser", number }, { cwd = gitdir, text = true }, function(result)
		vim.schedule(function()
			if result.code ~= 0 then
				vim.notify(result.stderr, vim.log.levels.ERROR)
				return
			end
			vim.ui.open(vim.trim(result.stdout))
		end)
	end)
end

local function open_pull_request_under_cursor()
	local number = pull_request_number_under_cursor()
	if not number then
		vim.notify("No pull request number under cursor", vim.log.levels.WARN)
		return
	end
	open_pull_request(number, blame_buffer_gitdir(0))
end

return {
	{
		"lewis6991/gitsigns.nvim",
		lazy = false,
		opts = { gh = true },
		init = function()
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "gitsigns-blame",
				callback = function(args)
					vim.keymap.set("n", "gx", open_pull_request_under_cursor, {
						buffer = args.buf,
						desc = "Open pull request under cursor",
					})
				end,
			})
		end,
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
		url = "https://codeberg.org/trevorhauter/gitportal.nvim",
		opts = {
			always_include_current_line = true,
		},
		keys = {
			{
				"<leader>go",
				function()
					require("gitportal").to_remote()
				end,
				mode = { "n", "v" },
			},
		},
	},
}
