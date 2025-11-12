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

-- Plugins
require("config.lazy")
-- require("lazy").setup("plugins")


-- Config Files
require("config/theme")
require("config/keybindings")
-- require("config/tree")
-- require('config/statusline')
-- require("config/neovide")
-- require("config/ccc")
-- require("config/dashboard")
-- require("config/tabs")


-- require('config/greeter')
--------------------------------------------------------
-- 🪶 Basic Settings
--------------------------------------------------------

-- Line Numbers
vim.wo.number = true
vim.wo.relativenumber = true


-- Change the color of the line numbers
vim.api.nvim_set_hl(0, 'LineNr', { fg = '#74c4c4', bg = 'NONE' })
vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#74c4c4', bg = 'NONE' })


-- Tab Spaces
vim.cmd("set tabstop=4")
vim.cmd("set shiftwidth=4")
vim.cmd("set expandtab")


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
vim.api.nvim_set_hl(0, "Normal", { fg = "#8affff", bg = "#003636" })
vim.api.nvim_set_hl(0, "NormalFloat", { fg = "#8affff", bg = "#003636" })

-- Set font and size
-- vim.o.guifont = "JetBrainsMono Nerd Font:h14"
vim.o.guifont = "Source Code Pro:h10.5"

vim.cmd [[
  highlight BufferCurrent guifg=#FFFFFF guibg=#003636
  highlight BufferVisible guifg=#CCCCCC guibg=#003636
  highlight BufferInactive guifg=#888888 guibg=#003636

  highlight BufferCurrentMod guifg=#fce094 guibg=#003636
  highlight BufferVisibleMod guibg=#003636
  highlight BufferInactiveMod guibg=#003636

  highlight BufferDefaultCurrent guifg=#FFFFFF guibg=#003636
  highlight BufferDefaultVisible guifg=#CCCCCC guibg=#003636
  highlight BufferDefaultInactive guifg=#888888 guibg=#003636

  highlight BufferInactiveSign guifg=#8affff  guibg=#003636
  highlight BufferVisibleSign  guifg=#8affff  guibg=#003636
  highlight BufferCurrentSign  guifg=#8affff  guibg=#003636

  highlight BufferDefaultInactiveSign guifg=#8affff  guibg=#003636
  highlight BufferDefaultVisibleSign  guifg=#8affff  guibg=#003636
  highlight BufferDefaultCurrentSign  guifg=#8affff  guibg=#003636

  highlight BufferDefaultInactiveIcon guifg=#8affff  guibg=#003636
  highlight BufferDefaultVisibleIcon  guifg=#8affff  guibg=#003636
  highlight BufferDefaultCurrentIcon  guifg=#8affff  guibg=#003636

  highlight BufferInactiveIcon guifg=#8affff  guibg=#003636
  highlight BufferVisibleIcon  guifg=#8affff  guibg=#003636
  highlight BufferCurrentIcon  guifg=#8affff  guibg=#003636

  highlight BufferTabpageFill guibg=#003636
]]

-- desired icon background colour
local ICON_BG = "#003636"

local function fix_devicon_bg()
  for _, name in ipairs(vim.fn.getcompletion('DevIcon', 'highlight')) do
    local hl = vim.api.nvim_get_hl(0, { name = name })
    -- Only change background (keep fg)
    vim.api.nvim_set_hl(0, name, { fg = hl.fg, bg = ICON_BG })
  end
end

-- Hook on colorscheme change / startup
vim.api.nvim_create_autocmd({ "ColorScheme", "VimEnter" }, {
  callback = function() vim.schedule(fix_devicon_bg) end,
})

-- Hook when buffers enter (so new filetypes show up)
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function() vim.schedule(fix_devicon_bg) end,
})

-- Wrap devicons.refresh
local ok, devicons = pcall(require, "nvim-web-devicons")
if ok then
  local orig_refresh = devicons.refresh
  devicons.refresh = function(...)
    local result = orig_refresh(...)
    vim.schedule(fix_devicon_bg)
    return result
  end
end
