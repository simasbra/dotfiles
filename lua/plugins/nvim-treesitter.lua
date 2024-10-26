return {
	'nvim-treesitter/nvim-treesitter',
	build = ':TSUpdate',
	opts = {
		ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' },
		auto_install = true,
		highlight = {
			enable = true,
			-- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
			--  If you are experiencing weird indenting issues, add the language to
			--  the list of additional_vim_regex_highlighting and disabled languages for indent.
			additional_vim_regex_highlighting = { 'ruby' },
		},
		indent = { enable = true, disable = { 'ruby', 'python' } },
	},
	config = function(_, opts)
		-- See `:help nvim-treesitter`

		---@diagnostic disable-next-line: missing-fields
		require('nvim-treesitter.install').compilers = { "zig", "clang" }
		require('nvim-treesitter.configs').setup(opts)

		-- Override `.h` files to be treated as `c` files
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "c,cpp",
			callback = function()
				if vim.fn.expand('%:e') == 'h' then
					vim.bo.filetype = 'c'
				end
			end,
		})
		-- There are additional nvim-treesitter modules that you can use to interact
		-- with nvim-treesitter. You should go explore a few and see what interests you:
		--    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
		--    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
		--    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
	end,
}
