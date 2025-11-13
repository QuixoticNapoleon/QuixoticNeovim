return function()
    local ls = require("luasnip")
    local s = ls.snippet
    local t = ls.text_node
    local i = ls.insert_node

    -- Minimal test snippet
    ls.snippets = {
        all = {
            s("hi", t("Hello, world!")),
        },
        lua = {
            s("fn", {
                t("function "), i(1, "name"), t("("), i(2), t({")", "\t"}),
                i(0),
                t({"", "end"})
            }),
        },
    }

    local opts = { silent = true, noremap = true }

    -- Expand or jump forward
    vim.keymap.set({ "i", "s" }, "<C-l>", function()
        if ls.expand_or_jumpable() then
            ls.expand_or_jump()
        end
    end, opts)

    -- Jump backward
    vim.keymap.set({ "i", "s" }, "<C-h>", function()
        if ls.jumpable(-1) then
            ls.jump(-1)
        end
    end, opts)

    -- Cycle choice nodes
    vim.keymap.set({ "i", "s" }, "<C-k>", function()
        if ls.choice_active() then
            ls.change_choice(1)
        end
    end, opts)

    -- Load snippets
    require("luasnip.loaders.from_vscode").lazy_load()
end

