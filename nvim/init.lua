vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.have_nerd_font = true

require("options")
require("keymaps")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

local plugins = {
	-- search, ui and other stuff
	require("plugins.telescope"),
	require("plugins.which-key"),
	require("plugins.vim-sleuth"),
	require("plugins.gitsigns"),
	require("plugins.lualine"),
	require("plugins.luvit-meta"),
	-- navigation
	require("plugins.oil"),
	require("plugins.undotree"),
	-- lsp stuff
	require("plugins.lazydev"),
	require("plugins.nvim-lspconfig"),
	require("plugins.nvim-treesitter"),
	require("plugins.nvim-cmp"),
	require("plugins.nvim-autopairs"),
	-- formatting and lint
	require("plugins.conform"),
	require("plugins.nvim-lint"),
	-- themes
	-- require("plugins.nightfox"),
	require("plugins.kanagawa"),
}

local options = {}

require("lazy").setup(plugins, options)
