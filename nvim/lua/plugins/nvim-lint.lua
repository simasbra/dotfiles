return {
	"mfussenegger/nvim-lint",
	event = {
		"BufReadPre",
		"BufNewFile",
	},
	config = function()
		local lint = require("lint")
		lint.linters_by_ft = {
			javascript = { "quick-lint-js", "eslint", "eslint_d" },
			javascriptreact = { "quick-lint-js", "eslint", "eslint_d" },
			typescript = { "eslint", "eslint_d" },
			typescriptreact = { "eslint", "eslint_d" },
			python = { "pylint" },
		}

		lint.linters.eslint.args = {
			"--no-warn-ignored",
			"--format",
			"json",
			"--stdin",
			"--stdin-filename",
			"--config",
			function()
				return vim.fn.getcwd() .. "/.eslintrc.json"
			end,
		}

		local eslint_d = require("lint.linters.eslint_d")
		eslint_d.args = vim.tbl_extend("force", {
			"--config",
			function()
				return vim.fn.getcwd() .. "/.eslintrc.json"
			end,
		}, eslint_d.args)

		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = lint_augroup,
			callback = function()
				lint.try_lint(nil, { ignore_errors = true })
			end,
		})

		vim.keymap.set("n", "<leader>tl", function()
			lint.try_lint(nil, { ignore_errors = true })
		end, { desc = "[T]oggle [l]int" })
	end,
}
