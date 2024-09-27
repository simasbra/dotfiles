vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.have_nerd_font = true

-- See `:help vim.opt`
vim.opt.number = true
vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = "a"

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = "yes"

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time. Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 5

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4

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

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)
