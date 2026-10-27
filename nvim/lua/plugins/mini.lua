local function statusline_filename()
	local name = vim.fn.expand("%:~:.")
	return (name == "" and "[No Name]" or name:gsub("%%", "%%%%")) .. "%m%r"
end

local function statusline_active()
	local statusline = require("mini.statusline")
	local mode, mode_hl = statusline.section_mode({ trunc_width = 120 })
	return statusline.combine_groups({
		{ hl = mode_hl, strings = { mode } },
		{ hl = "MiniStatuslineDevinfo", strings = { vim.b.gitsigns_head } },
		"%<",
		{ hl = "MiniStatuslineFilename", strings = { statusline_filename() } },
		"%=",
		{ hl = "MiniStatuslineFileinfo", strings = { "%l:%v" } },
		{ hl = mode_hl, strings = { "%P" } },
	})
end

local function statusline_inactive()
	return "%#MiniStatuslineInactive# " .. statusline_filename() .. "%="
end

return {
	"echasnovski/mini.nvim",
	lazy = false,
	version = false,
	config = function()
		require("mini.ai").setup()
		require("mini.cursorword").setup()
		local hipatterns = require("mini.hipatterns")
		hipatterns.setup({
			highlighters = {
				hex_color = hipatterns.gen_highlighter.hex_color(),
			},
		})
		require("mini.indentscope").setup({
			draw = {
				delay = 0,
				animation = function()
					return 0
				end,
			},
			options = {
				try_as_border = true,
			},
			symbol = "│",
		})
		require("mini.jump2d").setup()
		require("mini.statusline").setup({
			content = {
				active = statusline_active,
				inactive = statusline_inactive,
			},
			use_icons = false,
		})
		require("mini.surround").setup()
		require("mini.trailspace").setup()

		vim.api.nvim_create_autocmd("BufWritePre", {
			callback = function()
				require("mini.trailspace").trim()
			end,
		})
	end,
}
