local M = {}

local function reset(name)
	if vim.g.colors_name then
		vim.cmd.highlight("clear")
	end
	vim.g.colors_name = name
end

local function apply_highlights(highlights)
	for _, groups in ipairs(highlights) do
		for group, definition in pairs(groups) do
			vim.api.nvim_set_hl(0, group, definition)
		end
	end
end

local function apply_terminal_colors(terminal_colors)
	for index, color in ipairs(terminal_colors) do
		vim.g["terminal_color_" .. (index - 1)] = color
	end
end

local function apply_cursor_highlight()
	if not vim.o.guicursor:find("a:Cursor/lCursor", 1, true) then
		vim.opt.guicursor:append("a:Cursor/lCursor")
	end
end

function M.load(name, highlights, terminal_colors)
	reset(name)
	apply_highlights(highlights)
	apply_terminal_colors(terminal_colors)
	apply_cursor_highlight()
end

return M
