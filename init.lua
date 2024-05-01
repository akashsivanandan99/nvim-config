vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct
vim.g.maplocalleader = "\\" -- Same for `maplocalleader`

vim.opt.clipboard = "unnamedplus" -- copy to system clipboard

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})



local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
{
	"catppuccin/nvim", name = "catppuccin", priority = 1000 
},
"nvim-lua/plenary.nvim",
{
	'nvim-telescope/telescope.nvim', tag = '0.1.6',
},
{
	'norcalli/nvim-colorizer.lua',
},
{
	'nvim-treesitter/nvim-treesitter', build = ":TSUpdate",
         
},
{
	'lewis6991/gitsigns.nvim',
},
{
	'williamboman/mason.nvim',
	'williamboman/mason-lspconfig.nvim',
	'neovim/nvim-lspconfig',
},
{
	'startup-nvim/startup.nvim', 
	config = function()
		require "startup".setup()
	end
},
{
	'folke/flash.nvim',
	event = "VeryLazy",
	opts = {},
	keys = {
		{'s', mode = {'n', 'x', 'o'}, function() require('flash').jump() end, desc = 'Flash'},
		{'S', mode = {'n', 'x', 'o'}, function() require('flash').treesitter() end, desc = 'Flash Treesitter'},
                { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
                { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
                { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
	},
},
})

require('gitsigns').setup()
require("mason").setup()

require("mason-lspconfig").setup({
	ensure_installed = {
		"lua_ls", "rust_analyzer", 
		"clangd", "cssls", "gopls",
		"html", "jsonls", "jdtls", 
		"tsserver", "marksman", "pyright",
	}
})

vim.cmd.colorscheme "catppuccin-mocha"

