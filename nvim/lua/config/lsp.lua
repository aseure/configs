vim.lsp.config("elixirls", {
	cmd = { "/opt/homebrew/bin/elixir-ls" },
	settings = {
		elixirLS = {
			dialyzerEnabled = false,
			fetchDeps = false,
		},
	},
})

vim.lsp.enable({
	"bashls",
	"eslint",
	"lua_ls",
	"pyright",
	"ts_ls",
	"elixirls",
})

vim.diagnostic.config({
	underline = true,
	signs = true,
	virtual_text = false,
	float = {
		show_header = true,
		source = "if_many",
		border = "rounded",
	},
	severity_sort = true,
})
