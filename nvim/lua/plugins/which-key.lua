return {
	"folke/which-key.nvim",
	event = "VimEnter",
	config = function()
		require("which-key").setup()

		-- Document existing key chains
		require("which-key").add({
			{ "<leader>s", group = "[S]earch" },
			{ "<leader>t", group = "[T]oggle" },
			{ "<leader>f", group = "[F]ormat" },
			{ "<leader>h", group = "Git [H]unk", mode = { "n", "v" } },
		})
	end,
}
