return {
	"neovim/nvim-lspconfig",
	config = function()
		local capabilities = require("cmp_nvim_lsp").default_capabilities()
		local handlers = {
			["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
			["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
		}

		vim.lsp.config("lua_ls", {
			cmd = { "/opt/homebrew/bin/lua-language-server" },
			capabilities = capabilities,
			handlers = handlers,
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
				},
			},
		})
		vim.lsp.enable("lua_ls")

		vim.lsp.config("ts_ls", {
			cmd = { "/opt/homebrew/bin/typescript-language-server", "--stdio" },
			capabilities = capabilities,
			handlers = handlers,
			settings = {
				diagnostics = {
					enable = true,
				},
			},
		})
		vim.lsp.enable("ts_ls")

		vim.lsp.config("eslint", {
			flags = {
				allow_incremental_sync = false,
				debounce_text_changes = 1000,
			},
		})
		vim.lsp.enable("lua_ls")

		vim.lsp.config("elixirls", {
			cmd = { "/opt/homebrew/bin/elixir-ls" },
			capabilities = capabilities,
			handlers = handlers,
			settings = {
				elixirLS = {
					dialyzerEnabled = false,
					fetchDeps = false,
				},
			},
		})
		vim.lsp.enable("elixirls")

		vim.lsp.config("pyright", {
			cmd = { "/opt/homebrew/bin/pyright-langserver", "--stdio" },
			capabilities = capabilities,
			handlers = handlers,
		})
		vim.lsp.enable("pyright")

		vim.lsp.config("bashls", {
			cmd = { "/opt/homebrew/bin/bash-language-server", "start" },
			capabilities = capabilities,
			handlers = handlers,
		})
		vim.lsp.enable("bashls")

		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function(args)
				local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

				vim.keymap.set("n", "gd", function()
					if client:supports_method("textDocument/definition") and client.name ~= "elixirls" then
						vim.lsp.buf.definition()
					else
						vim.cmd(vim.api.nvim_replace_termcodes("normal <C-]>", true, true, true))
					end
				end)
			end,
		})
	end,
}
