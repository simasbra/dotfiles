-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-e>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-n>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Colemak remappings
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
local remappings = {
	-- Normal mode remappings
	{ "n", "J", "E" }, -- jump end WORD (swap E)
	{ "n", "j", "e" }, -- jump end word (swap e)
	{ "n", "N", "K" }, -- help (swap K)
	{ "n", "n", "j" }, -- down (swap j)
	{ "n", "E", "J" }, -- join lines (swap J)
	{ "n", "e", "l" }, -- right (swap l)
	{ "n", "K", "N" }, -- ok prev find (swap N)
	{ "n", "k", "n" }, -- ok next find (swap n)
	{ "n", "H", "H" }, -- no change
	{ "n", "h", "h" }, -- no change
	{ "n", "L", "L" }, -- no change
	{ "n", "l", "k" }, -- up (swap k)
	-- Visual mode remappings
	{ "v", "J", "E" },
	{ "v", "j", "e" },
	{ "v", "N", "K" },
	{ "v", "n", "j" },
	{ "v", "E", "J" },
	{ "v", "e", "l" },
	{ "v", "K", "N" },
	{ "v", "k", "n" },
	{ "v", "H", "H" }, -- no change
	{ "v", "h", "h" }, -- no change
	{ "v", "L", "L" }, -- no change
	{ "v", "l", "k" },
}
-- Apply the remappings
for _, mapping in ipairs(remappings) do
	map(mapping[1], mapping[2], mapping[3], opts)
end
