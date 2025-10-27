return {
	"neovim/nvim-lspconfig",
	config = function()
		local lspconfig = require("lspconfig")
		local fzf = require("fzf-lua")

		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function(ev)
				local opts = { buffer = ev.buf }
				vim.keymap.set("n", "gd", function()
					fzf.lsp_definitions()
				end)
				vim.keymap.set("n", "<leader>fs", function()
					fzf.lsp_document_symbols()
				end)
				vim.keymap.set("n", "<leader>fr", function()
					fzf.lsp_references()
				end)
				vim.keymap.set("n", "<A-Enter>", function()
					fzf.lsp_code_actions()
				end)
				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
				vim.keymap.set("n", "<leader>", vim.lsp.buf.rename, opts)
				vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
				vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
			end,
		})
	end,
}
