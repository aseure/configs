vim.lsp.config("ts_ls", {
	init_options = {
		preferences = {
			importModuleSpecifierPreference = "non-relative",
		},
	},
})

vim.lsp.enable({
	"bashls",
	"eslint",
	"expert",
	"lua_ls",
	"pyright",
	"ts_ls",
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
