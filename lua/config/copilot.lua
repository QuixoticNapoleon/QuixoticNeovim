-- ~/.config/nvim/lua/config/copilot.lua
return function()
	require("copilot").setup({
		panel = {
			enabled = true,
			auto_refresh = false,
			keymap = {
				jump_prev = "[[",
				jump_next = "]]",
				accept = "<CR>",
				refresh = "gr",
				open = "<M-CR>",
			},
			layout = {
				position = "bottom",
				ratio = 0.4,
			},
		},
		suggestion = {
			enabled = true,
			auto_trigger = true,
			hide_during_completion = true,
			debounce = 15,
			trigger_on_accept = true,
			keymap = {
				accept = "<M-l>",
				accept_word = "<M-k>",
				accept_line = false,
				next = "<M-]>",
				prev = "<M-[>",
				dismiss = "<C-]>",
			},
		},
		filetypes = {
			yaml = false,
			markdown = false,
			help = false,
			gitcommit = false,
			gitrebase = false,
			["."] = false,
		},
	})

	-- Hide copilot suggestions when cmp menu is open
	local cmp = require("cmp")
	cmp.event:on("menu_opened", function()
		vim.b.copilot_suggestion_hidden = true
	end)
	cmp.event:on("menu_closed", function()
		vim.b.copilot_suggestion_hidden = false
	end)
end
