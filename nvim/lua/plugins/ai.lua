return {
	{
		"milanglacier/minuet-ai.nvim",
		config = function()
			require("minuet").setup({
				provider = "claude",
				provider_options = {
					claude = {
						max_tokens = 256,
						model = "claude-haiku-4-5-20251001",
						stream = true,
						api_key = "ANTHROPIC_API_KEY",
					},
				},
			})
		end,
	},
}
