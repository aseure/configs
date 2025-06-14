vim.lsp.enable({
	"bashls",
	"elixirls",
	"eslint",
	"lua_ls",
	"ts_ls",
	"pyright",
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
