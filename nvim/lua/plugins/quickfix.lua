local function navigate(direction)
	if #vim.fn.getqflist() == 0 then
		return
	end

	local quicker = require("quicker")
	if not quicker.is_open() then
		quicker.open()
	end

	pcall(vim.cmd, direction)
end

local function jump_and_close()
	local loclist = vim.fn.win_gettype() == "loclist"
	vim.cmd.normal({ vim.keycode("<CR>"), bang = true })
	require("quicker").close({ loclist = loclist })
end

local function set_quickfix_keymaps(bufnr)
	vim.keymap.set("n", "o", jump_and_close, { buffer = bufnr, desc = "Jump to item and close the list" })
end

return {
	{
		"stevearc/quicker.nvim",
		ft = "qf",
		---@module "quicker"
		---@type quicker.SetupOptions
		opts = {
			keys = {
				{
					">",
					function()
						require("quicker").expand({ before = 2, after = 2, add_to_existing = true })
					end,
					desc = "Expand quickfix context",
				},
				{
					"<",
					function()
						require("quicker").collapse()
					end,
					desc = "Collapse quickfix context",
				},
			},
			on_qf = set_quickfix_keymaps,
			follow = {
				enabled = true,
			},
		},
		keys = {
			{
				"<leader>,",
				function()
					require("quicker").toggle({ focus = true })
				end,
				desc = "Toggle quickfix list",
			},
			{
				"<leader>.",
				function()
					require("quicker").toggle({ loclist = true, focus = true })
				end,
				desc = "Toggle location list",
			},
			{
				"<A-Down>",
				function()
					navigate("cnext")
				end,
				desc = "Next quickfix item",
			},
			{
				"<A-Up>",
				function()
					navigate("cprev")
				end,
				desc = "Previous quickfix item",
			},
			{
				"<leader>dq",
				function()
					vim.diagnostic.setqflist()
				end,
				desc = "Send diagnostics to quickfix list",
			},
		},
	},
}
