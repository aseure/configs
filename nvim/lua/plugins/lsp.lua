return {
	"neovim/nvim-lspconfig",
	config = function()
		local lspconfig = require("lspconfig")
		local pick = require("mini.extra")

		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function(ev)
				local opts = { buffer = ev.buf }
				vim.keymap.set("n", "gd", function()
					pick.pickers.lsp({ scope = "definition" })
				end)
				vim.keymap.set("n", "gs", function()
					pick.pickers.lsp({ scope = "document_symbol" })
				end)
				vim.keymap.set("n", "<leader>fr", function()
					pick.pickers.lsp({ scope = "references" })
				end)
				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
				vim.keymap.set("n", "<leader>", vim.lsp.buf.rename, opts)
				vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
				vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
			end,
		})
	end,
}
