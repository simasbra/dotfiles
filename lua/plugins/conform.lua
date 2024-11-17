local supported_formatters = {
	javascript = { "prettier" },
	javascriptreact = { "prettier" },
	html = { "prettier" },
	css = { "prettier" },
	json = { "prettier" },
	markdown = { "prettier" },
	python = { "pyink" },
	lua = { "stylua" },
}

return {
	"stevearc/conform.nvim",
	opts = {},
	keys = {
		{
			"<leader>fb",
			function()
				local filetype = vim.bo.filetype
				if supported_formatters[filetype] then
					require("conform").format({ async = true, lsp_format = "fallback" })
				else
					vim.notify("No formatter configured for this file type")
				end
			end,
			mode = "",
			desc = "[F]ormat [b]uffer",
		},
	},
	config = function()
		-- Convert supported_formatters keys to a set for enabled_filetypes
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

			-- If this is set, Conform will run the formatter asynchronously after save.
			-- It will pass the table to conform.format().
			-- This can also be a function that returns the table.
			format_after_save = false,

			-- Set the log level. Use `:ConformInfo` to see the location of the log file.
			log_level = vim.log.levels.ERROR,

			-- Conform will notify you when a formatter errors
			notify_on_error = true,

			-- Conform will notify you when no formatters are available for the buffer
			notify_no_formatters = true,

			-- Custom formatters and overrides for built-in formatters
			formatters = {
				my_formatter = {
					-- This can be a string or a function that returns a string.
					-- When defining a new formatter, this is the only field that is required
					command = "my_cmd",

					-- A list of strings, or a function that returns a list of strings
					-- Return a single string instead of a list to run the command in a shell
					--
					args = { "--stdin-from-filename", "$FILENAME" },
					-- If the formatter supports range formatting, create the range arguments here
					--
					range_args = function(self, ctx)
						return { "--line-start", ctx.range.start[1], "--line-end", ctx.range["end"][1] }
					end,

					-- Send file contents to stdin, read new contents from stdout (default true)
					-- When false, will create a temp file (will appear in "$FILENAME" args). The temp
					-- file is assumed to be modified in-place by the format command.
					stdin = true,

					-- A function that calculates the directory to run the command in
					cwd = require("conform.util").root_file({ ".editorconfig", "package.json" }),

					-- When cwd is not found, don't run the formatter (default false)
					require_cwd = true,

					-- When stdin=false, use this template to generate the temporary file that gets formatted
					tmpfile_format = ".conform.$RANDOM.$FILENAME",

					-- When returns false, the formatter will not be used
					condition = function(self, ctx)
						return vim.fs.basename(ctx.filename) ~= "README.md"
					end,

					-- Exit codes that indicate success (default { 0 })
					exit_codes = { 0, 1 },

					-- Environment variables. This can also be a function that returns a table.
					env = {
						VAR = "value",
					},

					-- Set to false to disable merging the config with the base definition
					inherit = true,

					-- When inherit = true, add these additional arguments to the beginning of the command.
					-- This can also be a function, like args

					prepend_args = { "--use-tabs" },
					-- When inherit = true, add these additional arguments to the end of the command.
					-- This can also be a function, like args
					append_args = { "--trailing-comma" },
				},
			},
		})
	end,
}
