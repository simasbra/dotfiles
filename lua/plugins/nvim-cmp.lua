return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		"dcampos/nvim-snippy",
		"dcampos/cmp-snippy",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-path",
	},
	config = function()
		-- See `:help cmp`
		local cmp = require "cmp"
		local snippy = require("snippy")
		snippy.setup({})

		cmp.setup {
			snippet = {
				expand = function(args)
					snippy.expand_snippet(args.body)
				end,
			},
			completion = { completeopt = "menu,menuone,noinsert" },
			mapping = cmp.mapping.preset.insert {
				-- Select the [n]ext item
				["<C-n>"] = cmp.mapping.select_next_item(),
				-- Select the [p]revious item
				["<C-p>"] = cmp.mapping.select_prev_item(),

				-- Scroll the documentation window [b]ack / [f]orward
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),

				-- Accept ([y]es) the completion.
				["<C-y>"] = cmp.mapping.confirm { select = true },

				-- <c-e> will move you to the right of each of the expansion locations.
				["<C-e>"] = cmp.mapping(function()
					if snippy.can_expand_or_advance() then
						snippy.expand_or_advance()
					end
				end, { "i", "s" }),
				-- <c-h> is similar, except moving you backwards.
				["<C-h>"] = cmp.mapping(function()
					if snippy.can_jump(-1) then
						snippy.previous()
					end
				end, { "i", "s" }),
			},
			sources = {
				{
					name = "lazydev",
					group_index = 0,
				},
				{ name = "nvim_lsp" },
				{ name = 'snippy' },
				{ name = "path" },
			},
		}
	end,
}
