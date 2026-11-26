vim.lsp.config("ts_ls", {
	init_options = {
		preferences = {
			importModuleSpecifierPreference = "non-relative",
		},
	},
})

vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using
				-- (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = {
					"vim",
					"require",
				},
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
		},
	},
})

vim.lsp.config("dexter", {
	cmd = { "dexter", "lsp" },
	filetypes = { "elixir", "eelixir", "heex" },
	root_markers = { ".dexter/dexter.db", ".dexter.db", "mix.exs", ".git" },
})

local is_uv_script = require("uv_script").is_uv_script

local function uv_script_python(path)
	vim.system({ "uv", "sync", "--script", path }):wait()
	local result = vim.system({ "uv", "python", "find", "--script", path }, { text = true }):wait()
	if result.code ~= 0 then
		return nil
	end
	return vim.trim(result.stdout)
end

local function start_ty_for_uv_script(args)
	if not is_uv_script(args.buf) then
		return
	end
	local path = vim.api.nvim_buf_get_name(args.buf)
	local python = uv_script_python(path)
	if not python then
		return
	end
	vim.lsp.start({
		name = "ty",
		cmd = { "ty", "server" },
		root_dir = vim.fs.dirname(path),
		settings = { ty = { configuration = { environment = { python = python } } } },
	}, {
		bufnr = args.buf,
		reuse_client = function(client, config)
			return client.name == config.name and vim.deep_equal(client.settings, config.settings)
		end,
	})
end

vim.lsp.config("ty", {
	root_dir = function(bufnr, on_dir)
		if not is_uv_script(bufnr) then
			on_dir(vim.fs.root(bufnr, vim.lsp.config.ty.root_markers))
		end
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "python",
	callback = start_ty_for_uv_script,
})

vim.lsp.enable({
	"bashls",
	"dexter",
	"eslint",
	"lua_ls",
	"ruff",
	"ts_ls",
	"ty",
	"gopls",
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
