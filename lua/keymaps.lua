--  See `:help wincmd` for a list of all window commands
-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

vim.keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true, desc = "Move [d]own a page" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true, desc = "Move [u]p a page" })

-- Colemak remappings
vim.keymap.set("n", "<C-w>h", "<C-w><C-h>", { noremap = true, desc = "Go to the left window" })
vim.keymap.set("n", "<C-w>e", "<C-w><C-l>", { noremap = true, desc = "Go to the right window" })
vim.keymap.set("n", "<C-w>n", "<C-w><C-j>", { noremap = true, desc = "Go to the down window" })
vim.keymap.set("n", "<C-w>l", "<C-w><C-k>", { noremap = true, desc = "Go to the up window" })

local map = vim.keymap.set
local remappings = {
	-- Normal mode remappings
	{ "n", "J", "E", "Jump end WORD (swap E)" },
	{ "n", "j", "e", "Jump end word (swap e)" },
	{ "n", "N", "K", "Help (swap K)" },
	{ "n", "n", "j", "Down (swap j)" },
	{ "n", "E", "J", "Join lines (swap J)" },
	{ "n", "e", "l", "Right (swap l)" },
	{ "n", "K", "Nzz", "Previous find (swap N)" }, -- Also centers the text
	{ "n", "k", "nzz", "Next find (swap n)" }, -- Also centers the text
	{ "n", "H", "H", "Screen top" },
	{ "n", "h", "h", "Left" },
	{ "n", "L", "L", "Screen bottom" },
	{ "n", "l", "k", "Up (swap k)" },
	-- Visual mode remappings
	{ "v", "J", "E", "Jump end WORD (swap E)" },
	{ "v", "j", "e", "Jump end word (swap e)" },
	{ "v", "N", "K", "Help (swap K)" },
	{ "v", "n", "j", "Down (swap j)" },
	{ "v", "E", "J", "Join lines (swap J)" },
	{ "v", "e", "l", "Right (swap l)" },
	{ "v", "K", "Nzz", "Previous find (swap N)" }, -- Also centers the text
	{ "v", "k", "nzz", "Next find (swap n)" }, -- Also centers the text
	{ "v", "H", "H", "Screen top" },
	{ "v", "h", "h", "Left" },
	{ "v", "L", "L", "Screen bottom" },
	{ "v", "l", "k", "Up (swap k)" },
}
-- Apply the remappings
for _, mapping in ipairs(remappings) do
	map(mapping[1], mapping[2], mapping[3], { noremap = true, silent = true, desc = mapping[4] })
end
