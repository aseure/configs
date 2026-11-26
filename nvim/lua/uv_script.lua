local M = {}

function M.is_uv_script(bufnr)
	local first_line = vim.api.nvim_buf_get_lines(bufnr, 0, 1, false)[1] or ""
	return first_line:match("^#!.*uv run") ~= nil
end

return M
