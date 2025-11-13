-- ~/.config/nvim/lua/snippets.lua
local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

ls.snippets = {
  all = {
    s("hi", t("Hello, world!")),       -- Type "hi" -> expand to Hello, world!
  },
  lua = {
    s("fn", {                           -- Type "fn" -> expand to a function template
      t("function "), i(1, "name"), t("("), i(2), t({")", "\t"}),
      i(0),
      t({"", "end"})
    }),
  },
}

