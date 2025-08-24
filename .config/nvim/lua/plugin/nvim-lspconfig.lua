return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = { "mason.nvim", "mason-lspconfig.nvim" },
	config = function()
		local border = "rounded"
		
		-- Add borders to LSP windows
		vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border })
		vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border })
		
		-- Configure diagnostics
		vim.diagnostic.config({
			virtual_text = { severity = { min = vim.diagnostic.severity.WARN } },
			underline = { severity = { min = vim.diagnostic.severity.WARN } },
			float = { border = border },
		})
		
		local lspconfig = require("lspconfig")

		-- Default capabilities for blink.cmp
		local capabilities = require('blink.cmp').get_lsp_capabilities()

		-- Basic LSP servers
		local servers = {
			"gopls", "bashls", "rust_analyzer", "hls",
			"ocamllsp", "ruby_lsp", "ruff", "ts_ls", "fsautocomplete", "julials"
		}
		
		for _, server in ipairs(servers) do
			lspconfig[server].setup({
				capabilities = capabilities,
			})
		end
		
		-- clangd with enhanced configuration for better documentation
		lspconfig.clangd.setup({
			capabilities = capabilities,
			cmd = {
				"clangd",
				"--background-index",
				"--clang-tidy",
				"--header-insertion=iwyu",
				"--completion-style=detailed",
				"--function-arg-placeholders",
				"--fallback-style=llvm",
				"--all-scopes-completion",
				"--cross-file-rename",
				"--log=verbose",
				"--ranking-model=heuristics",
				"--enable-config",
			},
			init_options = {
				usePlaceholders = true,
				completeUnimported = true,
				clangdFileStatus = true,
			},
			settings = {
				clangd = {
					semanticHighlighting = true,
				},
			},
		})
		
		-- Servers with specific configuration
		lspconfig.elixirls.setup({
			cmd = { "/Users/ander/.local/share/nvim/mason/packages/elixir-ls/language_server.sh" },
			capabilities = capabilities,
		})
		
		lspconfig.tinymist.setup({
			capabilities = capabilities,
			settings = {
				formatterMode = "typstyle",
				exportPdf = "onType",
			},
		})
		
		lspconfig.pylsp.setup({
			capabilities = capabilities,
			settings = {
				pylsp = {
					plugins = {
						pyflakes = { enabled = false },
						pylint = { enabled = false },
						pycodestyle = { enabled = false },
					},
				},
			},
		})
		
		lspconfig.lua_ls.setup({
			capabilities = capabilities,
			settings = {
				Lua = {
					runtime = { version = "LuaJIT" },
					diagnostics = { globals = { "vim" } },
					workspace = { library = vim.api.nvim_get_runtime_file("", true) },
					telemetry = { enable = false },
				},
			},
		})
	end,
}
