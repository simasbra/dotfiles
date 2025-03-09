return {
	"EdenEast/nightfox.nvim",
	config = function()
		require("nightfox").setup({
			options = {
				transparent = false, -- Disable setting background
				terminal_colors = false, -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
				dim_inactive = true, -- Non focused panes set to alternative background
				styles = { -- Style to be applied to different syntax groups
					comments = "italic", -- Value is any valid attr-list value `:help attr-list`
				},
			},
			palettes = {
				nightfox = {
					-- bg0 = "#131a24", -- Dark bg (status line and float)
					bg0 = "#080b0e",
					-- bg1 = "#192330", -- Default bg
					bg1 = "#000000",
					-- bg2 = "#212e3f", -- Lighter bg (colorcolm folds)
					bg2 = "#10171f",
					-- bg3 = "#29394f", -- Lighter bg (cursor line)
					bg3 = "#192330",
					-- bg4 = "#39506d", -- Conceal, border fg
					bg4 = "#222f41",

					-- sel0 = "#2b3b51", -- Popup bg, visual selection bg
					sel0 = "#222f41",
					-- sel1 = "#3c5372", -- Popup sel bg, search bg
					sel1 = "#334761",
				},
			},
		})

		vim.cmd.colorscheme("nightfox")
	end,
}
