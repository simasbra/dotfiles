local map = vim.keymap.set
--  See `:help wincmd` for a list of all window commands
-- Clear highlights on search when pressing <Esc> in normal mode
map("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
map("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Move up or down a page and keep cursor in the middle
map("n", "<C-d>", "<C-d>zz", { noremap = true, desc = "Move [d]own a page" })
map("n", "<C-u>", "<C-u>zz", { noremap = true, desc = "Move [u]p a page" })

-- Yanks to system clipboard
map("n", "<leader>y", '"+y', { desc = "Yank to system clipboard" })
map("n", "<leader>yy", '"+yy', { desc = "Yank to system clipboard" })
map("n", "<leader>Y", '"+y$', { desc = "Yank to system clipboard" })
map("v", "<leader>y", '"+y', { desc = "Yank to system clipboard" })

-- Makes current file executable
map("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true, desc = "Make file executable" })

-- Search and replace current word under cursor
map(
	"n",
	"<leader>sar",
	[[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gcI<Left><Left><Left><Left>]],
	{ desc = "[S]earch [A]nd [R]eplace current WORD under cursor" }
)

-- Colemak remappings

-- Window remappings
map("n", "<C-w>h", "<C-w><C-h>", { noremap = true, desc = "Go to the left window" })
map("n", "<C-w>k", "<C-w><C-j>", { noremap = true, desc = "Go to the down window" })
map("n", "<C-w>j", "<C-w><C-k>", { noremap = true, desc = "Go to the up window" })
map("n", "<C-w>l", "<C-w><C-l>", { noremap = true, desc = "Go to the right window" })
map("n", "<C-w><C-k>", "<C-w><C-j>", { noremap = true, desc = "Go to the down window" })
map("n", "<C-w><C-j>", "<C-w><C-k>", { noremap = true, desc = "Go to the up window" })

-- Swap k and j in colemak (more logical that upper key goes up and lower key goes down)
map("n", "k", "j")
map("n", "j", "k")
map("v", "k", "j")
map("v", "j", "k")
map("o", "k", "j")
map("o", "j", "k")

-- Moving selected text up or down
map("v", "K", ":m '>+1<CR>gv=gv", { desc = "Move highlighted text down" })
map("v", "J", ":m '<-2<CR>gv=gv", { desc = "Move highlighted text up" })

-- Centering found text
map("n", "N", "Nzz", { desc = "Previous find" })
map("n", "n", "Nzz", { desc = "Next find" })
map("v", "N", "Nzz", { desc = "Previous find" })
map("v", "n", "Nzz", { desc = "Next find" })
