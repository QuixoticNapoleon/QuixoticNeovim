-- ~/.config/nvim/lua/config/sudo.lua
-- :Sudow - Write the current buffer with sudo privileges

vim.api.nvim_create_user_command("Sudow", function()
	local filepath = vim.fn.expand("%:p")
	if filepath == "" then
		vim.notify("No file to write", vim.log.levels.ERROR)
		return
	end

	-- Prompt for password
	local password = vim.fn.inputsecret("Mot de passe: ")
	if password == "" then
		vim.notify("Cancelled", vim.log.levels.WARN)
		return
	end

	-- Write buffer contents to a temp file
	local tmpfile = vim.fn.tempname()
	vim.cmd("silent write! " .. vim.fn.fnameescape(tmpfile))

	-- Use sudo to copy temp file to target
	local cmd = string.format(
		"echo %s | sudo -S cp %s %s 2>&1",
		vim.fn.shellescape(password),
		vim.fn.shellescape(tmpfile),
		vim.fn.shellescape(filepath)
	)
	local output = vim.fn.system(cmd)
	local success = vim.v.shell_error == 0

	-- Clean up temp file
	os.remove(tmpfile)

	if success then
		-- Reload buffer to clear modified flag
		vim.cmd("edit!")
		vim.notify("Written with sudo: " .. filepath, vim.log.levels.INFO)
	else
		vim.notify("sudo write failed: " .. output, vim.log.levels.ERROR)
	end
end, { desc = "Write current buffer with sudo" })

-- Allow lowercase :sudow to expand to :Sudow
vim.cmd("cnoreabbrev sudow Sudow")
