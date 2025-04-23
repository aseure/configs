return {
	{ "hrsh7th/cmp-buffer" },
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/cmp-path" },
	{ "zbirenbaum/copilot-cmp", opts = {} },
	{ "zbirenbaum/copilot.lua", opts = {
		suggestion = { enabled = false },
		panel = { enabled = false },
	} },
	{ "onsails/lspkind.nvim" },
	{
		"hrsh7th/nvim-cmp",
		config = function()
			local cmp = require("cmp")
			local lspkind = require("lspkind")

			cmp.setup({
				sources = {
					{ name = "nvim_lsp" },
					{ name = "copilot" },
					{ name = "path" },
					{ name = "buffer", keyword_length = 5 },
				},
				formatting = {
					format = lspkind.cmp_format({
						mode = "symbol_text", -- show only symbol annotations
						symbol_map = { Copilot = "" },
						menu = {
							buffer = "[buffer]",
							nvim_lsp = "[lsp]",
							path = "[path]",
							copilot = "[copilot]",
						},
					}),
				},
				mapping = cmp.mapping.preset.insert({
					["<C-Space>"] = cmp.mapping.complete(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
				}),
				snippet = {
					expand = function(args)
						vim.snippet.expand(args.body)
					end,
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				experimental = {
					ghost_text = true,
				},
			})
		end,
	},
}
