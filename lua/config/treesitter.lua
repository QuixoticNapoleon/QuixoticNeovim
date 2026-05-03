-- ~/.config/nvim/lua/config/treesitter.lua
return function()
	-- New nvim-treesitter (main branch) API for Neovim 0.12+
	-- The plugin now only handles parser installation and queries.
	-- Highlighting, folding, etc. are handled by Neovim core.

	require("nvim-treesitter").setup({
		-- Directory to install parsers and queries to
		install_dir = vim.fn.stdpath("data") .. "/site",
	})

	-- Install parsers (no-op if already installed)
	require("nvim-treesitter").install({
		"c",
		"lua",
		"vim",
		"vimdoc",
		"query",
		"markdown",
		"markdown_inline",
		"python",
		"javascript",
		"cpp",
		"rust",
		"haskell",
		"commonlisp",
		"scheme",
		"clojure",
		"fennel",
	})

	-- Enable treesitter highlighting for all filetypes with a parser
	-- (Neovim 0.12 already enables this for Markdown by default,
	--  but this covers all other languages too.)
	vim.api.nvim_create_autocmd("FileType", {
		callback = function()
			-- Skip latex as before
			if vim.bo.filetype == "latex" or vim.bo.filetype == "tex" then
				return
			end
			pcall(vim.treesitter.start)
		end,
	})

	-- Treesitter-based folding (Neovim 0.12 native)
	vim.opt.foldlevelstart = 99
	vim.api.nvim_create_autocmd("FileType", {
		callback = function()
			if pcall(vim.treesitter.get_parser) then
				vim.wo[0][0].foldmethod = "expr"
				vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
			else
				vim.wo[0][0].foldmethod = "indent"
			end
		end,
	})

	-- Textobjects (nvim-treesitter-textobjects)
	require("nvim-treesitter-textobjects").setup({
		select = {
			lookahead = true,
		},
	})

	vim.keymap.set({ "x", "o" }, "af", function()
		require("nvim-treesitter-textobjects.select").select_textobject("@function.outer", "textobjects")
	end)
	vim.keymap.set({ "x", "o" }, "if", function()
		require("nvim-treesitter-textobjects.select").select_textobject("@function.inner", "textobjects")
	end)
	vim.keymap.set({ "x", "o" }, "ac", function()
		require("nvim-treesitter-textobjects.select").select_textobject("@class.outer", "textobjects")
	end)
	vim.keymap.set({ "x", "o" }, "ic", function()
		require("nvim-treesitter-textobjects.select").select_textobject("@class.inner", "textobjects")
	end)
end
