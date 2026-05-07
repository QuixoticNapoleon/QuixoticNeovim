--  ░██████╗░██╗░░░██╗██╗██╗░░██╗░█████╗░████████╗██╗░█████╗░░░░░░░███╗░░██╗██╗░░░██╗██╗███╗░░░███╗
--  ██╔═══██╗██║░░░██║██║╚██╗██╔╝██╔══██╗╚══██╔══╝██║██╔══██╗░░░░░░████╗░██║██║░░░██║██║████╗░████║
--  ██║██╗██║██║░░░██║██║░╚███╔╝░██║░░██║░░░██║░░░██║██║░░╚═╝█████╗██╔██╗██║╚██╗░██╔╝██║██╔████╔██║
--  ╚██████╔╝██║░░░██║██║░██╔██╗░██║░░██║░░░██║░░░██║██║░░██╗╚════╝██║╚████║░╚████╔╝░██║██║╚██╔╝██║
--  ░╚═██╔═╝░╚██████╔╝██║██╔╝╚██╗╚█████╔╝░░░██║░░░██║╚█████╔╝░░░░░░██║░╚███║░░╚██╔╝░░██║██║░╚═╝░██║
--  ░░░╚═╝░░░░╚═════╝░╚═╝╚═╝░░╚═╝░╚════╝░░░░╚═╝░░░╚═╝░╚════╝░░░░░░░╚═╝░░╚══╝░░░╚═╝░░░╚═╝╚═╝░░░░░╚═╝
--
--  By QuixoticNapoleon

--------------------------------------------------------
-- 🪶 Plugins
--------------------------------------------------------

require("config.lazy")
require("scripts.sudo")

--------------------------------------------------------
-- 🪶 Theme
--------------------------------------------------------

local dark_teal = "#003636"
vim.cmd("colorscheme terafox")

--------------------------------------------------------
-- 🪶 Basic Settings
--------------------------------------------------------

-- List Chars
vim.o.list = true
vim.opt.listchars = {
	tab = "»»",
	-- tab = "│»",
	space = "·",
	trail = "·",
	eol = "↲",
	extends = "›",
	precedes = "‹",
	nbsp = "␣",
}

-- Enable wrapping
vim.opt.wrap = true

-- Break lines at word boundaries
vim.opt.linebreak = true

-- Prefix shown on wrapped lines
vim.opt.showbreak = "↳ "

-- Indent wrapped lines to match indentation
vim.opt.breakindent = true

-- (Optional) fine-tune breakindent behavior
-- vim.opt.breakindentopt = "shift:2"

-- Line Numbers
vim.wo.number = true
vim.wo.relativenumber = true


-- Change the color of the line numbers
vim.api.nvim_set_hl(0, 'LineNr', { fg = '#74c4c4', bg = 'NONE' })
vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#74c4c4', bg = 'NONE' })


-- Tab/Space defaults (spaces for most languages)
vim.cmd("set tabstop=4")
vim.cmd("set shiftwidth=4")
vim.cmd("set expandtab")
vim.cmd("set smarttab")

-- Indentation Options
vim.opt.indentkeys:remove(":")
vim.opt.cinkeys:remove(":")
vim.opt.smartindent = true

-- Tabs for C/C++/Zig/Go/Lua/Shell
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "c", "cpp", "zig", "go", "lua", "sh", "zsh", "bash" },
	callback = function()
		vim.bo.expandtab = false
		vim.bo.tabstop = 4
		vim.bo.shiftwidth = 4
	end,
})



--------------------------------------------------------
-- 🪶 Basic Keybindings
--------------------------------------------------------

-- Leader Key
vim.g.mapleader = ' '

-- Tree
vim.api.nvim_set_keymap('n', '<leader>t', ':NvimTreeToggle<CR>', { noremap = true, silent = true })

-- ~/.config/nvim/lua/keymaps.lua
vim.keymap.set('n', '<Space>;', function()
	local row, col = unpack(vim.api.nvim_win_get_cursor(0)) -- save cursor
	local line = vim.api.nvim_get_current_line()

	-- Only add semicolon if it doesn't exist
	if not line:match(";$") then
		vim.api.nvim_set_current_line(line .. ";")
	end

	-- Restore cursor
	vim.api.nvim_win_set_cursor(0, {row, col})
end, { noremap = true, silent = true })


-- Telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})

-- Barbar (tab navigation)
vim.keymap.set('n', '<A-,>', '<Cmd>BufferPrevious<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<A-.>', '<Cmd>BufferNext<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<A-<>', '<Cmd>BufferMovePrevious<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<A->>', '<Cmd>BufferMoveNext<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<A-1>', '<Cmd>BufferGoto 1<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<A-2>', '<Cmd>BufferGoto 2<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<A-3>', '<Cmd>BufferGoto 3<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<A-4>', '<Cmd>BufferGoto 4<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<A-5>', '<Cmd>BufferGoto 5<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<A-6>', '<Cmd>BufferGoto 6<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<A-7>', '<Cmd>BufferGoto 7<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<A-8>', '<Cmd>BufferGoto 8<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<A-9>', '<Cmd>BufferGoto 9<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<A-0>', '<Cmd>BufferLast<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<A-p>', '<Cmd>BufferPin<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<A-c>', '<Cmd>BufferClose<CR>', { noremap = true, silent = true })

-- UndoTree
vim.cmd.packadd("nvim.undotree")
vim.keymap.set("n", "<leader>u", function()
	require("undotree").open()
end, { desc = "Open undotree" })


-- 'a' on empty line: enter insert mode with correct indentation
vim.keymap.set('n', 'a', function()
	local line = vim.api.nvim_get_current_line()
	if line:match("^%s*$") then
		return '"_cc'
	end
	return 'a'
end, { noremap = true, expr = true })

-- Clipboard
vim.opt.clipboard = "unnamedplus"

--------------------------------------------------------
-- 🪶 GUI and Colour Configuration
--------------------------------------------------------

-- Colors
vim.opt.termguicolors = true
vim.opt.background = "dark"  -- or "light" depending on theme

-- Remove Vim Background
vim.api.nvim_set_hl(0, "Normal", { ctermbg = "none", bg = "none" })

-- Colors (Foreground and Background)
-- Neovide uses Neovim's colorscheme, so we’ll override via highlight groups
-- vim.api.nvim_set_hl(0, "Normal", { fg = "#8affff", bg = "#003636" })
vim.api.nvim_set_hl(0, "Normal", { fg = "#8affff", bg = "none", ctermbg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { fg = "#8affff", bg = "#003636" })


-- Set font and size
-- vim.o.guifont = "JetBrainsMono Nerd Font:h14"
-- vim.o.guifont = "Source Code Pro:h10.5"
vim.o.guifont = "JetBrainsMono Nerd Font:h10.5"

-- Deleting keymaps
vim.keymap.del('n', 'y<C-g>')


-- General Neovim GUI
vim.cmd([[
	highlight Normal guibg=NONE ctermbg=NONE
	highlight NormalNC guibg=NONE ctermbg=NONE
	highlight LineNr guibg=NONE
	highlight SignColumn guibg=NONE
	highlight WinSeparator guifg=#74c4c4 guibg=NONE
	
	highlight Pmenu guibg=NONE
	highlight PmenuSel guifg=#FFFFFF guibg=#008282
	highlight Substitute guifg=#FFFFFF guibg=#008282
	highlight FloatBorder guifg=#74c4c4
	highlight StatusLine guibg=#003636
	
	highlight NvimTreeNormal guibg=NONE
	highlight NvimTreeNormalFloat guibg=NONE
	highlight NvimTreeCursorLine guibg=#395e5e
	
	highlight Visual guibg=#395e5e

	highlight EndOfBuffer guifg=#016868
	highlight SpecialKey guifg=#016868
	highlight Trailing guifg=#016868
	highlight Whitespace guifg=#016868
	highlight NonText guifg=#016868
	
	highlight TelescopeBorder guifg=#74c4c4 guibg=NONE
]])


-- For Tabs and Folds
vim.cmd [[
	highlight TabLineFill guibg=NONE

	highlight BufferCurrent guifg=#FFFFFF guibg=NONE
	highlight BufferVisible guifg=#CCCCCC guibg=NONE
	highlight BufferInactive guifg=#888888 guibg=NONE
	
	highlight BufferCurrentMod guifg=#fce094 guibg=NONE
	highlight BufferVisibleMod guibg=NONE
	highlight BufferInactiveMod guifg=#a89768 guibg=NONE
	
	highlight BufferDefaultCurrent guifg=#FFFFFF guibg=NONE
	highlight BufferDefaultVisible guifg=#CCCCCC guibg=NONE
	highlight BufferDefaultInactive guifg=#888888 guibg=NONE
	
	highlight BufferInactiveSign guifg=#8affff  guibg=NONE
	highlight BufferVisibleSign  guifg=#8affff  guibg=NONE
	highlight BufferCurrentSign  guifg=#8affff  guibg=NONE
	
	highlight BufferDefaultInactiveSign guifg=#8affff  guibg=NONE
	highlight BufferDefaultVisibleSign  guifg=#8affff  guibg=NONE
	highlight BufferDefaultCurrentSign  guifg=#8affff  guibg=NONE
	
	highlight BufferDefaultInactiveIcon guifg=#8affff  guibg=NONE
	highlight BufferDefaultVisibleIcon  guifg=#8affff  guibg=NONE
	highlight BufferDefaultCurrentIcon  guifg=#8affff  guibg=NONE
	
	highlight BufferInactiveIcon guifg=#8affff  guibg=NONE
	highlight BufferVisibleIcon  guifg=#8affff  guibg=NONE
	highlight BufferCurrentIcon  guifg=#8affff  guibg=NONE
	
	highlight BufferTabpageFill guibg=NONE
	
	highlight Folded guifg=#74c4c4  guibg=NONE
	highlight FoldColumn guifg=#74c4c4  guibg=NONE
]]

-- Syntax Highlighting
vim.cmd([[
	highlight Comment guifg=#00B4B4
	highlight Operator guifg=#5cb5b5
]])
vim.api.nvim_set_hl(0, "@variable", { fg = "#5cb5b5" })
