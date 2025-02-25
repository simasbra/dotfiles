local map = vim.keymap.set

--  See `:help wincmd` for a list of all window commands
-- Clear highlights on search when pressing <Esc> in normal mode
map("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
map("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

map("n", "<C-d>", "<C-d>zz", { noremap = true, desc = "Move [d]own a page" })
map("n", "<C-u>", "<C-u>zz", { noremap = true, desc = "Move [u]p a page" })

-- Colemak remappings

-- Window remappings
map("n", "<C-w>h", "<C-w><C-h>", { noremap = true, desc = "Go to the left window" })
map("n", "<C-w>n", "<C-w><C-j>", { noremap = true, desc = "Go to the down window" })
map("n", "<C-w>l", "<C-w><C-k>", { noremap = true, desc = "Go to the up window" })
map("n", "<C-w>e", "<C-w><C-l>", { noremap = true, desc = "Go to the right window" })
map("n", "<C-w><C-h>", "<C-w><C-h>", { noremap = true, desc = "Go to the left window" })
map("n", "<C-w><C-n>", "<C-w><C-j>", { noremap = true, desc = "Go to the down window" })
map("n", "<C-w><C-l>", "<C-w><C-k>", { noremap = true, desc = "Go to the up window" })
map("n", "<C-w><C-e>", "<C-w><C-l>", { noremap = true, desc = "Go to the right window" })

-- Control remappings
local remappings = {
	-- Normal mode
	{ "n", "J", "E", "Jump end WORD (swap E)" },
	{ "n", "j", "e", "Jump end word (swap e)" },
	{ "n", "N", "K", "Help (swap K)" },
	{ "n", "n", "j", "Down (swap j)" },
	{ "n", "E", "J", "Join lines (swap J)" },
	{ "n", "e", "l", "Right (swap l)" },
	{ "n", "K", "Nzz", "Previous find (swap N)" }, -- Also centers the text
	{ "n", "k", "nzz", "Next find (swap n)" }, -- Also centers the text
	{ "n", "l", "k", "Up (swap k)" },
	-- Visual mode
	{ "v", "J", "E", "Jump end WORD (swap E)" },
	{ "v", "j", "e", "Jump end word (swap e)" },
	{ "v", "N", "K", "Help (swap K)" },
	{ "v", "n", "j", "Down (swap j)" },
	{ "v", "E", "J", "Join lines (swap J)" },
	{ "v", "e", "l", "Right (swap l)" },
	{ "v", "K", "Nzz", "Previous find (swap N)" },
	{ "v", "k", "nzz", "Next find (swap n)" },
	{ "v", "l", "k", "Up (swap k)" },
	-- Operator pending mode
	{ "o", "J", "E", "Jump end WORD (swap E)" },
	{ "o", "j", "e", "Jump end word (swap e)" },
	{ "o", "n", "j", "Down (swap j)" },
	{ "o", "e", "l", "Right (swap l)" },
	{ "o", "K", "Nzz", "Previous find (swap N)" },
	{ "o", "k", "nzz", "Next find (swap n)" },
	{ "o", "l", "k", "Up (swap k)" },
}
-- Apply the remappings
for _, mapping in ipairs(remappings) do
	map(mapping[1], mapping[2], mapping[3], { noremap = true, silent = true, desc = mapping[4] })
end
