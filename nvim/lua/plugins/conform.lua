return {
	"stevearc/conform.nvim",
	opts = {
		mode = "normal",
		formatters_by_ft = {
			bash = { "shfmt" },
			html = { "prettier" },
			javascript = { "prettier" },
			javascriptreact = { "prettier" },
			json = { "prettier" },
			jsonc = { "prettier" },
			lua = { "stylua" },
			css = { "prettier" },
			markdown = { "prettier" },
			python = { "ruff_organize_imports", "ruff_format" },
			scss = { "prettier" },
			typescript = { "prettier" },
			typescriptreact = { "prettier" },
			yaml = { "prettier" },
		},
		format_on_save = {
			timeout_ms = 1000,
			lsp_format = "fallback",
		},
	},
}
