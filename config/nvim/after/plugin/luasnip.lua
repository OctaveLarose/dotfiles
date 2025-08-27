---@diagnostic disable: unused-local
local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local extras = require("luasnip.extras")
local l = extras.lambda
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local conds = require("luasnip.extras.expand_conditions")
local postfix = require("luasnip.extras.postfix").postfix
local types = require("luasnip.util.types")
local parse = require("luasnip.util.parser").parse_snippet
local ms = ls.multi_snippet
local k = require("luasnip.nodes.key_indexer").new_key

-- test from the doc, reminder for now
-- ls.add_snippets("all", {
--   s("ternary", {
--     -- equivalent to "${1:cond} ? ${2:then} : ${3:else}"
--     i(1, "cond"), t(" ? "), i(2, "then"), t(" : "), i(3, "else")
--   })
-- })

ls.add_snippets("tex", {
  s("code", {
    t({ "\\code{" }), i(1, "CODE"), t({ "}" })
  }),
  s("emph", {
    t({ "\\emph{" }), i(1, "EMPH"), t({ "}" })
  }),
  s("todo", {
    t({ "\\todo{" }), i(1, "TODO"), t({ "}" })
  }),
  s("fig", {
    t({ "\\begin{figure}[H]",
      "\t\\centering",
      "\t% FIGURE",
      "\t\\caption{" }),
    i(1, "caption"),
    t({ "}", "\t\\label{fig:" }),
    i(2, "label"),
    t({ "}", "\\end{figure}" })
  })
})
