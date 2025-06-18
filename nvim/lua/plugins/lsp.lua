return {
	"neovim/nvim-lspconfig",
	config = function()
		local lspconfig = require("lspconfig")
		local snacks = require("snacks")
		local snacks_cfg = { matcher = { frecency = true } }

		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function(ev)
				local opts = { buffer = ev.buf }
				vim.keymap.set("n", "gd", function()
					snacks.picker.lsp_definitions(snacks_cfg)
				end)
				vim.keymap.set("n", "gs", function()
					snacks.picker.lsp_symbols(snacks_cfg)
				end)
				vim.keymap.set("n", "grr", function()
					snacks.picker.lsp_references(snacks_cfg)
				end)
				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
				vim.keymap.set("n", "grn", vim.lsp.buf.rename, opts)
				vim.keymap.set("n", "gra", vim.lsp.buf.code_action, opts)
				vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
				vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
			end,
		})
	end,
}
