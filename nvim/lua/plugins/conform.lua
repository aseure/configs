return {
	"stevearc/conform.nvim",
	opts = {
		mode = "normal",
		formatters_by_ft = {
			bash = { "shfmt" },
			javascript = { "prettier" },
			json = { "prettier" },
			lua = { "stylua" },
			css = { "prettier" },
			python = { "ruff_organize_imports", "ruff_format" },
			typescript = { "prettier" },
		},
		format_on_save = {
			timeout_ms = 1000,
			lsp_format = "fallback",
		},
	},
}
