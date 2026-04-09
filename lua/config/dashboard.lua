return function()
local db = require("dashboard")

-- Safe fortune function
local function quote()
	local handle = io.popen([[while :; do f=$(fortune); [ $(printf '%s\n' "$f" | wc -l) -eq 1 ] && { printf '%s\n' "$f"; break; }; done]])
	local result = handle:read('*a')
	handle:close()
	result = result:gsub('\r', ''):gsub('\n', ' ')
	return result
end

db.setup {
	theme = "hyper",
	config = {
		week_header = {
			enable = false  -- or true if you want date/time header
		},
		header = {
			"│  ╲   │ │",
			"│   ╲  │ │",
			"│ │╲ ╲ │ │",
			"│ │ ╲ ╲│ │",
			"│ │  ╲   │",
			"│ │   ╲  │",
			"                                                  ",
			"Neovim " .. vim.version().major .. '.' .. vim.version().minor .. '.' .. vim.version().patch,
			"   " .. os.date("%A, %B %d, %Y"),  -- your custom date/day line
			"",
			"[TIP: To exit Vim, use a Sledgehammer!]",
			""
		},
		shortcut = {
			{
				icon = " ",
				desc = "New File",
				key  = "n",
				action = "enew"
			},
			{
				icon = " ",
				desc = "Find File",
				key  = "f",
				action = "Telescope find_files"
			},
			{
				icon = " ",
				desc = "Recent Files",
				key  = "r",
				action = "Telescope oldfiles"
			},
			{
				icon = "󰓢 ",
				desc = "Open Config",
				key  = "c",
				action = "edit ~/.config/nvim/"
			},
			{
				icon = "󰣪 ",
				desc = "SLEDGEHAMMER!",
				action = "qa"
			},
		},
		packages = {
			enable = true  -- set to true if you want plugin count display
		},
		mru = {
			enable = true,  -- set true if you want MRU files
			limit  = 10,
			icon   = " ",
			label  = "Recent",
			cwd_only = false
		},
		project = {
			enable = false,  -- set true if you want project list
			limit  = 8,
			icon   = " ",
			label  = "Projects",
			action = "Telescope find_files cwd="
		},
		footer = { "", quote() },
	},
}
end
