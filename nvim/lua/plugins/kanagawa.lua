return {
	"rebelot/kanagawa.nvim",
	config = function()
		-- Default options:
		require("kanagawa").setup({
			compile = false, -- enable compiling the colorscheme
			undercurl = true, -- enable undercurls
			commentStyle = { italic = true },
			functionStyle = {},
			keywordStyle = { italic = true },
			statementStyle = { bold = true },
			typeStyle = {},
			transparent = false, -- do not set background color
			dimInactive = true, -- dim inactive window `:h hl-NormalNC`
			terminalColors = false, -- define vim.g.terminal_color_{0,17}
			colors = { -- add/modify theme and palette colors
				palette = {
					sumiInk0 = "#16161D",
					sumiInk1 = "#181820",
					sumiInk2 = "#1a1a22",
					sumiInk3 = "#000000",
					sumiInk4 = "#1F1F28",
					sumiInk5 = "#2A2A37",
					sumiInk6 = "#363646",
				},
				theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
			},
			overrides = function(colors) -- add/modify highlights
				return {}
			end,
			theme = "wave", -- Load "wave" theme when 'background' option is not set
			background = { -- map the value of 'background' option to a theme
				dark = "wave", -- try "dragon" !
				light = "lotus",
			},
		})

		-- setup must be called before loading
		vim.cmd("colorscheme kanagawa")
	end,
}
