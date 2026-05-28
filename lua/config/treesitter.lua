-- ~/.config/nvim/lua/config/treesitter.lua
return function()
	-- New nvim-treesitter (main branch) API for Neovim 0.12+
	-- The plugin now only handles parser installation and queries.
	-- Highlighting, folding, etc. are handled by Neovim core.

	require("nvim-treesitter").setup({
		-- Directory to install parsers and queries to
		install_dir = vim.fn.stdpath("data") .. "/site",
	})

	-- Make bundled queries available for parsers shipped with the plugin
	-- (install() symlinks queries to site/ but only after successful compilation;
	-- this ensures bundled parsers work even without running install)
	local ts_runtime = vim.fn.stdpath("data") .. "/lazy/nvim-treesitter/runtime"
	if vim.fn.isdirectory(ts_runtime) == 1 then
		vim.opt.runtimepath:append(ts_runtime)
	end

	-- Pre-install common parsers (no-op if already installed)
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
		"java",
		"fortran",
		"typst",
	})

	-- Track languages we've already attempted to auto-install
	local attempted = {}

	local function setup_folding(buf)
		if pcall(vim.treesitter.get_parser, buf) then
			vim.wo[0][0].foldmethod = "expr"
			vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
		else
			vim.wo[0][0].foldmethod = "indent"
		end
	end

	-- Auto-install parsers and enable highlighting/folding on FileType
	vim.opt.foldlevelstart = 99
	vim.api.nvim_create_autocmd("FileType", {
		callback = function(args)
			local buf = args.buf
			local ft = vim.bo[buf].filetype
			if ft == "latex" or ft == "tex" then return end

			local lang = vim.treesitter.language.get_lang(ft) or ft
			local has_queries = #vim.api.nvim_get_runtime_file("queries/" .. lang .. "/highlights.scm", true) > 0

			-- Parser and queries both available: just enable highlighting + folding
			if has_queries and pcall(vim.treesitter.start, buf) then
				setup_folding(buf)
				return
			end

			-- Don't re-attempt a failed install
			if attempted[lang] then
				-- Still set up folding for parsers that loaded without queries
				setup_folding(buf)
				return
			end
			attempted[lang] = true

			-- Auto-install the missing parser/queries
			local ok, handle = pcall(require("nvim-treesitter").install, { lang }, { force = true })
			if not ok then return end

			-- When install finishes, enable highlighting on the buffer
			handle:await(function(err)
				if err then return end
				vim.schedule(function()
					if vim.api.nvim_buf_is_valid(buf) then
						pcall(vim.treesitter.start, buf)
						setup_folding(buf)
					end
				end)
			end)
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
