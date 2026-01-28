return {
	"stevearc/conform.nvim",
	opts = {
		mode = "normal",
		formatters_by_ft = {
			bash = { "shfmt" },
			elixir = { "mix" },
			javascript = { "prettier" },
			json = { "prettier" },
			lua = { "stylua" },
			css = { "prettier" },
			python = { "isort", "black" },
			typescript = { "prettier" },
		},
		format_on_save = {
			timeout_ms = 1000,
			lsp_format = "fallback",
		},
	},
}
