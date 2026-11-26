local uv_script = require("uv_script")

vim.filetype.add({
	pattern = {
		[".*"] = {
			function(_, bufnr)
				if uv_script.is_uv_script(bufnr) then
					return "python"
				end
			end,
			{ priority = -math.huge },
		},
	},
})
