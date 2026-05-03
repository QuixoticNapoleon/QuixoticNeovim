-- ~/.config/nvim/lua/plugins/init.lua
return {
	-- LSP
	{
	"neovim/nvim-lspconfig",
	config = function()
		require("config.lsp")()
	end,
	},

	-- TreeSitter
	{"nvim-treesitter/nvim-treesitter", branch = 'main', lazy = false, build = ":TSUpdate",
	config = function()
		require("config.treesitter")()
	end,},
	{"nvim-treesitter/nvim-treesitter-textobjects", branch = "main", lazy = false, },

	-- Autopairs
	{
	'windwp/nvim-autopairs',
	event = "InsertEnter",
	config = true
	},

	-- Surround
	{ 
	'nvim-mini/mini.surround', 
	version = false,
	config = function()
		require("mini.surround").setup({})
	end
	},

	-- Auto Completion
	{
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",  -- lazy load when entering insert mode
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"saadparwaiz1/cmp_luasnip",
		"L3MON4D3/LuaSnip",
		"rafamadriz/friendly-snippets",
		"onsails/lspkind.nvim",
	},
	config = function()
		require("config.completion")()  -- load the separate config file
	end,
	},

	-- Snippets
	{
	"L3MON4D3/LuaSnip",
	version = "v2.*",
	dependencies = { "rafamadriz/friendly-snippets" },
	build = "make install_jsregexp",
	config = function()
		-- Call the returned function from your module
		require("config.luasnip")()
	end,
	},

	-- File Explorer
	{ "nvim-tree/nvim-tree.lua", config = require("config.tree") },

	-- Icons
	{ "nvim-tree/nvim-web-devicons" },

	-- Color Picker
	{ "uga-rosa/ccc.nvim", config = require("config.colorpicker") },

	-- Status Line
	{ "nvim-lualine/lualine.nvim", config = require("config.statusline"), opts = {} },

	-- Smooth Scrolling
	{ "karb94/neoscroll.nvim", opts = {} },

	-- Telescope
	{ "nvim-telescope/telescope.nvim", tag = "0.1.8", config = require("config.telescope") },

	-- Plenary
	{ "nvim-lua/plenary.nvim" },

	-- LaTeX
	{ "lervag/vimtex", ft = "tex", init = require("config.vimtex") },

	-- Grammar & Spell Checking
	{ "rhysd/vim-grammarous", ft = "tex" },

	-- Git Signs
	{ "lewis6991/gitsigns.nvim" },

	-- Tab Bar
	{
	"romgrk/barbar.nvim",
	version = "^1.0.0",
	config = require("config.tabs"),
	},

	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		---@module "ibl"
		---@type ibl.config
		opts = {},
		config = require("config.indent"),
	},

	-- Dashboard
	{ "nvimdev/dashboard-nvim", event = "VimEnter", config = require("config.dashboard") },

	-- Hex Editing
	-- { 'ArcaneSpecs/HexEditor.nvim', 
	--   config = function()
	--     require("config.hex")()  -- note the () if your lsp.lua returns a function
	--   end,
	-- },
	'RaafatTurki/hex.nvim',

	-- Java LSP
	{
		'mfussenegger/nvim-jdtls',
		ft = 'java',
		config = function()
			require("config.jdtls")()
		end,
	},

	-- Debugging
	'mfussenegger/nvim-dap',

	-- Git
	'tpope/vim-fugitive',

	-- Commenting
	'tpope/vim-commentary',

	-- Marks
	{
		'chentoast/marks.nvim',
		event = 'VeryLazy',
		opts = {
			default_mappings = false,
		},
	},

	-- Flash (quick navigation)
	{
		'folke/flash.nvim',
		event = 'VeryLazy',
		config = function()
			require('config.flash')()
		end,
	},

	-- Multiple Cursors
	{
		'jake-stewart/multicursor.nvim',
		branch = '1.0',
		event = 'VeryLazy',
		config = function()
			require('config.multicursor')()
		end,
	},

	-- Markdown Rendering
	{
		'MeanderingProgrammer/render-markdown.nvim',
		dependencies = { 'nvim-treesitter/nvim-treesitter' },
		ft = { 'markdown' },
		opts = {
			enabled = false,
		},
	},

	-- Copilot
	-- {
	-- 	"zbirenbaum/copilot.lua",
	-- 	cmd = "Copilot",
	-- 	event = "InsertEnter",
	-- 	config = function()
	-- 		require("config.copilot")()
	-- 	end,
	-- },

	-- Themes
	"martinsione/darkplus.nvim",
	"folke/tokyonight.nvim",
	"navarasu/onedark.nvim",
	"EdenEast/nightfox.nvim"

}
