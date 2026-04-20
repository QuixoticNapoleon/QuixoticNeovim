-- ~/.config/nvim/lua/config/jdtls.lua
return function()
	local jdtls = require("jdtls")

	local cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	if cmp_ok then
		capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
	end

	local root_dir = require("jdtls.setup").find_root({ ".git", "pom.xml", "build.gradle", "gradlew", ".project", "mvnw" })
	if not root_dir then
		root_dir = vim.fn.getcwd()
	end

	local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
	local workspace_dir = vim.fn.stdpath("data") .. "/jdtls-workspace/" .. project_name

	local config = {
		cmd = {
			"jdtls",
			"-data", workspace_dir,
		},
		root_dir = root_dir,
		capabilities = capabilities,
		on_attach = function(client, bufnr)
			local opts = { noremap = true, silent = true, buffer = bufnr }
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
			vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
			vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
			vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
			-- jdtls-specific mappings
			vim.keymap.set("n", "<leader>oi", jdtls.organize_imports, opts)
		end,
		settings = {
			java = {
				signatureHelp = { enabled = true },
				completion = {
					favoriteStaticMembers = {},
				},
				sources = {
					organizeImports = {
						starThreshold = 9999,
						staticStarThreshold = 9999,
					},
				},
			},
		},
	}

	jdtls.start_or_attach(config)
end
