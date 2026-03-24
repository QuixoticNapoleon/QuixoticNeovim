return function()
	local mc = require('multicursor-nvim')
	local set = vim.keymap.set

	mc.setup()

	set({ 'n', 'x' }, '<Up>', function()
		mc.lineAddCursor(-1)
	end, { desc = 'Add cursor above' })
	set({ 'n', 'x' }, '<Down>', function()
		mc.lineAddCursor(1)
	end, { desc = 'Add cursor below' })
	set({ 'n', 'x' }, '<leader><Up>', function()
		mc.lineSkipCursor(-1)
	end, { desc = 'Skip cursor above' })
	set({ 'n', 'x' }, '<leader><Down>', function()
		mc.lineSkipCursor(1)
	end, { desc = 'Skip cursor below' })

	set({ 'n', 'x' }, '<leader>n', function()
		mc.matchAddCursor(1)
	end, { desc = 'Add next match cursor' })
	set({ 'n', 'x' }, '<leader>N', function()
		mc.matchAddCursor(-1)
	end, { desc = 'Add previous match cursor' })
	set({ 'n', 'x' }, '<leader>s', function()
		mc.matchSkipCursor(1)
	end, { desc = 'Skip next match cursor' })
	set({ 'n', 'x' }, '<leader>S', function()
		mc.matchSkipCursor(-1)
	end, { desc = 'Skip previous match cursor' })

	set('n', '<C-LeftMouse>', mc.handleMouse, { desc = 'Toggle mouse cursor' })
	set('n', '<C-LeftDrag>', mc.handleMouseDrag, { desc = 'Drag mouse cursor' })
	set('n', '<C-LeftRelease>', mc.handleMouseRelease, { desc = 'Release mouse cursor' })
	set({ 'n', 'x' }, '<C-q>', mc.toggleCursor, { desc = 'Toggle multicursor' })

	mc.addKeymapLayer(function(layer_set)
		layer_set({ 'n', 'x' }, '<Left>', mc.prevCursor)
		layer_set({ 'n', 'x' }, '<Right>', mc.nextCursor)
		layer_set({ 'n', 'x' }, '<leader>x', mc.deleteCursor)
		layer_set('n', '<Esc>', function()
			if not mc.cursorsEnabled() then
				mc.enableCursors()
			else
				mc.clearCursors()
			end
		end)
	end)

	vim.api.nvim_set_hl(0, 'MultiCursorCursor', { reverse = true })
	vim.api.nvim_set_hl(0, 'MultiCursorVisual', { link = 'Visual' })
	vim.api.nvim_set_hl(0, 'MultiCursorSign', { link = 'SignColumn' })
	vim.api.nvim_set_hl(0, 'MultiCursorMatchPreview', { link = 'Search' })
	vim.api.nvim_set_hl(0, 'MultiCursorDisabledCursor', { reverse = true })
	vim.api.nvim_set_hl(0, 'MultiCursorDisabledVisual', { link = 'Visual' })
	vim.api.nvim_set_hl(0, 'MultiCursorDisabledSign', { link = 'SignColumn' })
end
