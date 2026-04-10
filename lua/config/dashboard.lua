return function()
local db = require("dashboard")

-- Fortune quote (supports multiline)
local function quote()
	local handle = io.popen("fortune -s")
	local result = handle:read("*a")
	handle:close()
	local lines = { "" }
	for line in result:gmatch("[^\r\n]+") do
		table.insert(lines, line)
	end
	table.insert(lines, "")
	return lines
end

local header_art = {
	"│  ╲   │ │",
	"│   ╲  │ │",
	"│ │╲ ╲ │ │",
	"│ │ ╲ ╲│ │",
	"│ │  ╲   │",
	"│ │   ╲  │",
}

db.setup {
	theme = "hyper",
	config = {
		week_header = {
			enable = false
		},
		header = vim.list_extend(vim.list_extend({}, header_art), {
			"                                                  ",
			"Neovim v" .. vim.version().major .. '.' .. vim.version().minor .. '.' .. vim.version().patch,
			"   " .. os.date("%A, %B %d, %Y"),  -- your custom date/day line
			"",
			"[TIP: To exit Vim, use a Sledgehammer!]",
			""
		}),
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
				key  = "SMASH!",
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
		footer = quote(),
	},
}

-- Two-tone header: blue left, green right
vim.api.nvim_set_hl(0, "DashboardHeaderBlue", { fg = "#3394D4" })
vim.api.nvim_set_hl(0, "DashboardHeaderGreen", { fg = "#75B35F" })
local ns = vim.api.nvim_create_namespace("dashboard_header_colours")

vim.api.nvim_create_autocmd("User", {
	pattern = "DashboardLoaded",
	callback = function()
		local bufnr = vim.api.nvim_get_current_buf()
		if vim.bo[bufnr].filetype ~= "dashboard" then return end
		for i, line in ipairs(vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)) do
			local trimmed = line:match("^%s*(.-)%s*$")
			for _, a in ipairs(header_art) do
				if trimmed == a then
					local row = i - 1
					local col = line:find("%S") - 1
					local mid = col + vim.str_byteindex(trimmed, 4)
					vim.api.nvim_buf_add_highlight(bufnr, ns, "DashboardHeaderBlue", row, col, mid)
					vim.api.nvim_buf_add_highlight(bufnr, ns, "DashboardHeaderGreen", row, mid, col + #trimmed)
					break
				end
			end
		end
	end,
})
end
