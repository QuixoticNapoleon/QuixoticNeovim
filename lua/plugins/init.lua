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


    -- Autocompletion
    { "hrsh7th/nvim-cmp" },
    { "hrsh7th/cmp-nvim-lsp" },
    
    -- Snippets
    {
        "L3MON4D3/LuaSnip",
        -- follow latest release.
        version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        -- install jsregexp (optional!).
        build = "make install_jsregexp",
        config = function()
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

    -- Dashboard
    { "nvimdev/dashboard-nvim", event = "VimEnter", dependencies = { "nvim-tree/nvim-web-devicons" }, config = require("config.dashboard") },
    
    -- Themes
    "martinsione/darkplus.nvim",
    "folke/tokyonight.nvim",
    "navarasu/onedark.nvim"
}

