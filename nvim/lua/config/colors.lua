local state = vim.fs.joinpath(vim.env.HOME, ".local", "state", "colorscheme", "name")

local function selected_colorscheme()
	local file = io.open(state)
	if not file then
		return "peony"
	end
	local name = file:read("*l")
	file:close()
	return name
end

local function apply_selected_colorscheme()
	local name = selected_colorscheme()
	if name and name ~= "" and name ~= vim.g.colors_name then
		vim.cmd.colorscheme(name)
	end
end

local function follow_selected_colorscheme()
	if not vim.uv.fs_stat(state) then
		return
	end
	local watcher = vim.uv.new_fs_event()
	watcher:start(state, {}, vim.schedule_wrap(apply_selected_colorscheme))
end

apply_selected_colorscheme()
follow_selected_colorscheme()
