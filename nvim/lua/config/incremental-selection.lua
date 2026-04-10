local M = {}

local node_stack = {}
local buf_tick = nil

local function reset()
	node_stack = {}
	buf_tick = nil
end

local function select_node(node)
	local sr, sc, er, ec = node:range()
	-- end position from :range() is exclusive; adjust to inclusive
	if ec > 0 then
		ec = ec - 1
	else
		-- node ends at col 0 of next line, roll back to end of previous line
		er = er - 1
		local line = vim.api.nvim_buf_get_lines(0, er, er + 1, true)[1]
		ec = math.max(0, #line - 1)
	end
	vim.api.nvim_buf_set_mark(0, "<", sr + 1, sc, {})
	vim.api.nvim_buf_set_mark(0, ">", er + 1, ec, {})
	vim.cmd("normal! gv")
end

function M.increment()
	local tick = vim.api.nvim_buf_get_changedtick(0)
	if tick ~= buf_tick then
		reset()
	end
	buf_tick = tick

	local node
	if #node_stack == 0 then
		node = vim.treesitter.get_node()
		if not node then
			return
		end
	else
		node = node_stack[#node_stack]:parent()
		if not node then
			-- already at root, re-select current
			node = node_stack[#node_stack]
		end
	end

	table.insert(node_stack, node)
	select_node(node)
end

function M.decrement()
	if #node_stack <= 1 then
		vim.cmd("normal! \27") -- escape to deselect
		reset()
		return
	end

	table.remove(node_stack)
	select_node(node_stack[#node_stack])
end

return M
