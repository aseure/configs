local M = {}

local EMPTY_TREE = "4b825dc642cb6eb9a060e54bf8d69288fbee4904"

local function git_root()
	return vim.fs.root(0, ".git") or vim.uv.cwd()
end

local function run_git(root, args)
	return vim.system(vim.list_extend({ "git" }, args), { cwd = root, text = true }):wait()
end

local function git_lines(root, args)
	local result = run_git(root, args)
	if result.code ~= 0 then
		vim.notify(result.stderr, vim.log.levels.ERROR)
		return nil
	end
	return vim.split(result.stdout, "\n", { trimempty = true })
end

local function parent_or_empty_tree(root, commit)
	local result = run_git(root, { "rev-parse", "--verify", "--quiet", "--short", commit .. "^" })
	return result.code == 0 and vim.trim(result.stdout) or EMPTY_TREE
end

local function review_of(root, commits)
	local newest_first = git_lines(root, vim.list_extend({ "rev-list", "--no-walk", "--abbrev-commit" }, commits))
	if not newest_first then
		return nil
	end
	local tip, oldest = newest_first[1], newest_first[#newest_first]
	return {
		root = root,
		base = parent_or_empty_tree(root, oldest),
		tip = tip,
		label = #newest_first == 1 and tip or ("%s^..%s"):format(oldest, tip),
	}
end

local function is_review_window(win)
	return vim.b[vim.api.nvim_win_get_buf(win)].commit_diff ~= nil
end

local function open_pane()
	if vim.iter(vim.api.nvim_tabpage_list_wins(0)):any(is_review_window) then
		vim.cmd("botright vnew")
	else
		vim.cmd("tabnew")
	end
end

local function fill_review_buffer(lines, label, path)
	local buf = vim.api.nvim_get_current_buf()
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
	vim.bo[buf].buftype = "nofile"
	vim.bo[buf].bufhidden = "wipe"
	vim.bo[buf].swapfile = false
	vim.bo[buf].modifiable = false
	vim.bo[buf].filetype = "diff"
	vim.b[buf].commit_diff = { label = label, path = path }
	pcall(vim.api.nvim_buf_set_name, buf, ("commit-diff://%s/%s"):format(label, path))
	vim.wo.winbar = (" %s  %s"):format(label:gsub("%%", "%%%%"), path:gsub("%%", "%%%%"))
end

local function open_file_diff(review, path)
	local lines = git_lines(review.root, { "diff", review.base, review.tip, "--", path })
	if not lines then
		return
	end
	open_pane()
	fill_review_buffer(lines, review.label, path)
end

local function open_file_diffs(review, paths)
	for _, path in ipairs(paths) do
		open_file_diff(review, path)
	end
	vim.cmd("wincmd =")
end

local function pick_files(review)
	require("fzf-lua").fzf_exec(("git diff --name-only %s %s"):format(review.base, review.tip), {
		prompt = review.label .. " files> ",
		cwd = review.root,
		fzf_opts = { ["--multi"] = true },
		preview = ("git diff --color %s %s -- {}"):format(review.base, review.tip),
		actions = {
			enter = function(selected)
				open_file_diffs(review, selected)
			end,
		},
	})
end

local function pick_files_of_commits(root, commits)
	local review = review_of(root, commits)
	if review then
		pick_files(review)
	end
end

local pick_branch

local function branch_log_command(branch)
	return require("fzf-lua").defaults.git.commits.cmd .. " " .. vim.fn.shellescape(branch)
end

local function commit_hash(line)
	return line:match("[^ ]+")
end

local function pick_commit(root, branch)
	require("fzf-lua").git_commits({
		cwd = root,
		cmd = branch and branch_log_command(branch),
		prompt = branch and (branch .. " commits> "),
		fzf_opts = { ["--no-multi"] = false, ["--multi"] = true },
		actions = {
			enter = function(selected)
				pick_files_of_commits(root, vim.tbl_map(commit_hash, selected))
			end,
			["ctrl-s"] = {
				fn = function()
					pick_branch(root)
				end,
				header = "switch branch",
			},
			["ctrl-d"] = false,
		},
	})
end

local function selected_branch(line)
	local _, branch = line:match("%s-([%+%*]?)%s+([^ ]+)")
	return branch
end

pick_branch = function(root)
	require("fzf-lua").git_branches({
		cwd = root,
		actions = {
			enter = function(selected)
				pick_commit(root, selected_branch(selected[1]))
			end,
			["ctrl-x"] = false,
			["ctrl-a"] = false,
		},
	})
end

function M.run(args)
	local root = git_root()
	if #args == 0 then
		pick_commit(root)
	elseif #args == 1 then
		pick_files_of_commits(root, { args[1] })
	else
		local review = review_of(root, { args[1] })
		if review then
			open_file_diffs(review, vim.list_slice(args, 2))
		end
	end
end

return M
