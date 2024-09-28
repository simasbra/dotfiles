return {
	"EdenEast/nightfox.nvim",
	config = function()
		require("nightfox").setup {
			options = {
				-- Compiled file"s destination location
				compile_path = vim.fn.stdpath "cache" .. "/nightfox",
				compile_file_suffix = "_compiled", -- Compiled file suffix
				transparent = false, -- Disable setting background
				terminal_colors = true, -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
				dim_inactive = true, -- Non focused panes set to alternative background
				module_default = true, -- Default enable value for modules
				colorblind = {
					enable = false, -- Enable colorblind support
					simulate_only = false, -- Only show simulated colorblind colors and not diff shifted
					severity = {
						protan = 0, -- Severity [0,1] for protan (red)
						deutan = 0, -- Severity [0,1] for deutan (green)
						tritan = 0, -- Severity [0,1] for tritan (blue)
					},
				},
				styles = { -- Style to be applied to different syntax groups
					comments = "italic", -- Value is any valid attr-list value `:help attr-list`
					conditionals = "NONE",
					constants = "NONE",
					functions = "NONE",
					keywords = "NONE",
					numbers = "NONE",
					operators = "NONE",
					strings = "NONE",
					types = "NONE",
					variables = "NONE",
				},
				inverse = { -- Inverse highlight for different types
					match_paren = false,
					visual = false,
					search = false,
				},
				modules = { -- List of various plugins and additional options
					-- ...
				},
			},
			palettes = {
				nightfox = {
					-- Original:
					-- bg0 = "#131a24", -- Dark bg (status line and float)
					-- bg1 = "#192330", -- Default bg
					-- bg2 = "#212e3f", -- Lighter bg (colorcolm folds)
					-- bg3 = "#29394f", -- Lighter bg (cursor line)
					-- bg4 = "#39506d", -- Conceal, border fg

					-- fg0 = "#d6d6d7", -- Lighter fg
					-- fg1 = "#cdcecf", -- Default fg
					-- fg2 = "#aeafb0", -- Darker fg (status line)
					-- fg3 = "#71839b", -- Darker fg (line numbers, fold colums)

					-- sel0 = "#2b3b51", -- Popup bg, visual selection bg
					-- sel1 = "#3c5372", -- Popup sel bg, search bg

					bg0 = "#080b0e", -- Dark bg (status line and float)
					bg1 = "#000000", -- Default bg
					bg2 = "#10171f", -- Lighter bg (colorcolm folds)
					bg3 = "#192330", -- Lighter bg (cursor line)
					bg4 = "#222f41", -- Conceal, border fg

					sel0 = "#222f41", -- Popup bg, visual selection bg
					sel1 = "#334761", -- Popup sel bg, search bg
				},
				specs = {},
				groups = {},
			},
		}
	end,
}
