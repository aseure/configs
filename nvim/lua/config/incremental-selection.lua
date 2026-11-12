local M = {}

local node_stack = {}
local buf_tick = nil

local function reset()
	node_stack = {}
	buf_tick = nil
end

local function current_selection()
	local v = vim.fn.getpos("v")
	local c = vim.fn.getpos(".")
	local first, last = { v[2], v[3] }, { c[2], c[3] }
	if last[1] < first[1] or (last[1] == first[1] and last[2] < first[2]) then
		first, last = last, first
	end
	return { first[1], first[2], last[1], last[2] }
end

local function same_selection(a, b)
	return a[1] == b[1] and a[2] == b[2] and a[3] == b[3] and a[4] == b[4]
end

local function same_range(a, b)
	local asr, asc, aer, aec = a:range()
	local bsr, bsc, ber, bec = b:range()
	return asr == bsr and asc == bsc and aer == ber and aec == bec
end

local function larger_ancestor(node)
	local parent = node:parent()
	while parent and same_range(parent, node) do
		parent = parent:parent()
	end
	return parent
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

local function push(node)
	select_node(node)
	table.insert(node_stack, { node = node, selection = current_selection() })
end

local function stack_is_stale()
	if #node_stack == 0 then
		return false
	end
	if vim.api.nvim_buf_get_changedtick(0) ~= buf_tick then
		return true
	end
	return not same_selection(node_stack[#node_stack].selection, current_selection())
end

function M.increment()
	if stack_is_stale() then
		reset()
	end
	buf_tick = vim.api.nvim_buf_get_changedtick(0)

	local node
	if #node_stack == 0 then
		node = vim.treesitter.get_node()
		if not node then
			return
		end
	else
		local top = node_stack[#node_stack].node
		node = larger_ancestor(top)
		if not node then
			-- already at root, re-select current
			select_node(top)
			return
		end
	end

	push(node)
end

function M.decrement()
	if stack_is_stale() or #node_stack <= 1 then
		vim.cmd("normal! \27") -- escape to deselect
		reset()
		return
	end

	table.remove(node_stack)
	select_node(node_stack[#node_stack].node)
end

return M
