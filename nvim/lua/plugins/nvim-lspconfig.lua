return {
	"neovim/nvim-lspconfig",
	dependencies = {
		-- Automatically install LSPs and related tools to stdpath for Neovim
		{ "williamboman/mason.nvim", config = true },
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		-- Useful status updates for LSP.
		{ "j-hui/fidget.nvim", opts = {} },
		-- Allows extra capabilities provided by nvim-cmp
		-- "hrsh7th/cmp-nvim-lsp",
		-- Allows extra capabilities provided by blink.cmp
		"saghen/blink.cmp",
	},
	config = function()
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
			callback = function(event)
				local map = function(keys, func, desc, mode)
					mode = mode or "n"
					vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
				end
				map("gra", vim.lsp.buf.code_action, "Goto Code Action", { "n", "x" })
				-- This is where a variable was first declared, or where a function is defined, etc.
				-- To jump back, press <C-t>.
				map("grd", require("telescope.builtin").lsp_definitions, "Goto Definition (Back <C-t>)")
				-- This is Goto Declaration. For example, in C this would take you to the header.
				map("grD", vim.lsp.buf.declaration, "Goto Declaration")
				map("gri", require("telescope.builtin").lsp_implementations, "Goto Implementation")
				map("grn", vim.lsp.buf.rename, "Rename")
				map("grr", require("telescope.builtin").lsp_references, "Goto References")
				map("grt", require("telescope.builtin").lsp_type_definitions, "Goto Type Definition")
				map("gO", require("telescope.builtin").lsp_document_symbols, "Open Document Symbols")
				map("gW", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Open Workspace Symbols")
				map("N", vim.lsp.buf.hover, "Display hover information")

				-- The following two auto commands are used to highlight references of the
				-- word under your cursor when your cursor rests there for a little while.
				--    See `:help CursorHold` for information about when this is executed
				local client = vim.lsp.get_client_by_id(event.data.client_id)
				if
					client
					and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight)
				then
					local highlight_augroup =
						vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
					vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
						buffer = event.buf,
						group = highlight_augroup,
						callback = vim.lsp.buf.document_highlight,
					})

					vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
						buffer = event.buf,
						group = highlight_augroup,
						callback = vim.lsp.buf.clear_references,
					})

					vim.api.nvim_create_autocmd("LspDetach", {
						group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
						callback = function(event2)
							vim.lsp.buf.clear_references()
							vim.api.nvim_clear_autocmds({
								group = "kickstart-lsp-highlight",
								buffer = event2.buf,
							})
						end,
					})
				end

				-- The following code creates a keymap to toggle inlay hints in your
				-- code, if the language server you are using supports them
				if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
					map("<leader>th", function()
						vim.lsp.inlay_hint.enable(
							not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf })
						)
					end, "[T]oggle Inlay [H]ints")
				end
			end,
		})

		-- local capabilities = vim.lsp.protocol.make_client_capabilities()
		-- capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

		local capabilities = require("blink.cmp").get_lsp_capabilities()

		-- Enable the following language servers
		--  Add any additional override configuration in the following tables. Available keys are:
		--  - cmd (table): Override the default command used to start the server
		--  - filetypes (table): Override the default list of associated filetypes for the server
		--  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
		--  - settings (table): Override the default settings passed when initializing the server.
		-- See `:help lspconfig-all` for a list of all the pre-configured LSPs
		local servers = {
			bashls = {},
			clangd = {},
			-- csharp_ls = {},
			omnisharp = {},
			eslint = {
				settings = {
					eslint = {
						autoFixOnSave = true,
						packageManager = "yarn",
						workingDirectories = { mode = "auto" },
						-- experimental = {
						-- 	useFlatConfig = true,
						-- },
					},
				},
			},
			gopls = {
				settings = {
					gopls = {
						gofumpt = true,
					},
				},
			},
			gofumpt = {},
			html = {},
			lua_ls = {},
			-- pyink = { enabled = true },
			-- pylint = {},
			-- pylsp = {
			-- 	settings = {
			-- 		pylsp = {
			-- 			plugins = {
			-- 				pylint = {
			-- 					enabled = true,
			-- 					args = { "--rcfile=pyproject.toml", "--max-line-length=120" },
			-- 				},
			-- 				pycodestyle = { enabled = false },
			-- 				mccabe = { enabled = false },
			-- 				pyflakes = { enabled = false },
			-- 				pyink = { enabled = true },
			-- 			},
			-- 		},
			-- 	},
			-- },
			shfmt = {},
			stylua = {},
			ts_ls = {},
		}

		require("mason").setup()
		require("mason-tool-installer").setup({ ensure_installed = ensure_installed })
		require("mason-lspconfig").setup({
			ensure_installed = {},
			automatic_installation = {},
			handlers = {
				function(server_name)
					local server = servers[server_name] or {}
					-- This handles overriding only values explicitly passed by the server configuration above.
					-- Useful when disabling certain features of an LSP
					server.capabilities =
						vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
					require("lspconfig")[server_name].setup(server)
				end,
			},
		})
		-- require("lspconfig").ruby_lsp.setup({
		-- 	capabilities = capabilities,
		-- 	init_options = {
		-- 		formatter = "standard",
		-- 		linters = { "standard" },
		-- 	},
		-- })
	end,
}
