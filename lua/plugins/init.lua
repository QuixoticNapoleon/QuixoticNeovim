-- ~/.config/nvim/lua/plugins/init.lua
return {
    -- LSP
	{
      "neovim/nvim-lspconfig",
      config = function()
        require("config.lsp")()  -- note the () if your lsp.lua returns a function
      end,
    },

    -- TreeSitter
    {"nvim-treesitter/nvim-treesitter", branch = 'master', lazy = false, build = ":TSUpdate",
    config = function()
        require("config.treesitter")() 
    end,},
    {"nvim-treesitter/nvim-treesitter-textobjects", lazy = false, },

    -- Autopairs
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = true
        -- use opts = {} for passing setup options
        -- this is equivalent to setup({}) function
    },

    {
    "kylechui/nvim-surround",
    version = "^3.0.0", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
        require("nvim-surround").setup({
            -- Configuration here, or leave empty to use defaults
        })
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


    -- Autocompletion
    -- { "hrsh7th/nvim-cmp" },
    -- { "hrsh7th/cmp-nvim-lsp" },
    
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
    { "nvim-telescope/telescope.nvim", tag = "0.1.8", dependencies = { "nvim-lua/plenary.nvim" }, config = require("config.telescope") },
    
    -- Plenary
    { "nvim-lua/plenary.nvim" },

    -- LaTeX
    { "lervag/vimtex", ft = "tex", config = require("config.vimtex") },
    
    -- Grammar & Spell Checking
    { "rhysd/vim-grammarous", ft = "tex" },
    
    -- Tab Bar
    {
      "romgrk/barbar.nvim",
      dependencies = {
        "lewis6991/gitsigns.nvim",      -- optional: for git status
        "nvim-tree/nvim-web-devicons",  -- optional: for file icons
      },
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
    { "nvimdev/dashboard-nvim", event = "VimEnter", dependencies = { "nvim-tree/nvim-web-devicons" }, config = require("config.dashboard") },




	-- Cursor
	"sphamba/smear-cursor.nvim",
	  opts = {
    -- Smear cursor when switching buffers or windows.
    smear_between_buffers = true,

    -- Smear cursor when moving within line or to neighbor lines.
    -- Use `min_horizontal_distance_smear` and `min_vertical_distance_smear` for finer control
    smear_between_neighbor_lines = true,

    -- Draw the smear in buffer space instead of screen space when scrolling
    scroll_buffer_space = true,

    -- Set to `true` if your font supports legacy computing symbols (block unicode symbols).
    -- Smears and particles will look a lot less blocky.
    legacy_computing_symbols_support = false,

    -- Smear cursor in insert mode.
    -- See also `vertical_bar_cursor_insert_mode` and `distance_stop_animating_vertical_bar`.
    smear_insert_mode = true,
		   cursor_color = "#ff4000",
   particles_enabled = true,
   stiffness = 0.5,
   trailing_stiffness = 0.2,
   trailing_exponent = 5,
   damping = 0.6,
   gradient_exponent = 0,
   gamma = 1,
   never_draw_over_target = true, -- if you want to actually see under the cursor
   hide_target_hack = true,       -- same
   particle_spread = 1,
   particles_per_second = 500,
   particles_per_length = 50,
   particle_max_lifetime = 800,
   particle_max_initial_velocity = 20,
   particle_velocity_from_cursor = 0.5,
   particle_damping = 0.15,
   particle_gravity = -50,
   min_distance_emit_particles = 0,
  },
    
    -- Themes
    "martinsione/darkplus.nvim",
    "folke/tokyonight.nvim",
    "navarasu/onedark.nvim",
    "EdenEast/nightfox.nvim"
}

