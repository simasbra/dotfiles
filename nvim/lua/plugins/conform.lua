return {
	"stevearc/conform.nvim",
	opts = {},
	config = function()
		-- Convert supported_formatters keys to a set for enabled_filetypes
		local supported_formatters = {
			javascript = { "prettier" },
			javascriptreact = { "prettier" },
			typescript = { "prettier" },
			typescriptreact = { "prettier" },
			json = { "prettier" },
			html = { "prettier" },
			css = { "prettier" },
			scss = { "prettier" },
			markdown = { "prettier" },
			python = { "pyink" },
			lua = { "stylua" },
			c = { "clang-format" },
			h = { "clang-format" },
			cpp = { "clang-format" },
			-- cs = { "clang-format" },
			sh = { "shfmt" },
			zsh = { "shfmt" },
		}

		local enabled_filetypes = {}
		for ft, _ in pairs(supported_formatters) do
			enabled_filetypes[ft] = true
		end

		require("conform").setup({
			-- Map of filetype to formatters
			formatters_by_ft = supported_formatters,

			-- Set this to change the default values when calling conform.format()
			-- This will also affect the default values for format_on_save/format_after_save
			default_format_opts = {
				lsp_format = "fallback",
			},

			-- If this is set, Conform will run the formatter on save.
			-- It will pass the table to conform.format().
			-- This can also be a function that returns the table.
			format_on_save = function(bufnr)
				if enabled_filetypes[vim.bo[bufnr].filetype] then
					return {
						timeout_ms = 500,
						lsp_format = "fallback",
					}
				else
					return {
						timeout_ms = 500,
						lsp_format = "never",
					}
				end
			end,

			-- Set the log level. Use `:ConformInfo` to see the location of the log file.
			log_level = vim.log.levels.ERROR,

			-- Conform will notify you when a formatter errors
			notify_on_error = true,

			-- Conform will notify you when no formatters are available for the buffer
			notify_no_formatters = true,

			-- Custom formatters and overrides for built-in formatters
			formatters = {
				shfmt = {
					prepend_args = { "-ci" },
				},
				pyink = {
					prepend_args = { "--line-length", "100" },
				},
				 ["clang-format"] = vim.fn.has("win32") == 0 and {
					prepend_args = {
						"-style=file:"
							.. os.getenv("XDG_CONFIG_HOME")
							.. "/clang-format/config.yaml",
					} or {},
				},
				prettier = {
					prepend_args = { "--print-width", "100" },
				},
			},
			vim.keymap.set("n", "<leader>fb", function()
				local filetype = vim.bo.filetype
				if supported_formatters[filetype] then
					require("conform").format({ async = true, lsp_format = "fallback" })
				else
					vim.notify("No formatter configured for this file type")
				end
			end, { desc = "[f]ormat [b]uffer" }),
		})
	end,
}
