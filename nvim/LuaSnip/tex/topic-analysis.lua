-- Abbreviations used in LuaSnip docs
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

return {
  -- Define countcap snippet for countable intersection
  s(
    { trig = "countcap", desc = "countable intersection", trigEngine = "plain", wordTrig = true },
    c(1, {
      fmta(
        [[
          \cap_{<> = <>}^<>
        ]],
        { i(1, "n"), i(2, "1"), i(3, "\\infty") }
      ),
    }),
    c(2, {
      fmta(
        [[
          \cap_{<> \in \mathbb{<>}}
        ]],
        { i(1, "n"), i(2, "N") }
      ),
    })
  ),

  -- Define countcup snippet for countable union
  s(
    { trig = "countcup", desc = "countable union", trigEngine = "plain", wordTrig = true },
    c(1, {
      fmta(
        [[
          \cup_{<> = <>}^<>
        ]],
        { i(1, "n"), i(2, "1"), i(3, "\\infty") }
      ),
    }),
    c(2, {
      fmta(
        [[
          \cup_{<> \in \mathbb{<>}}
        ]],
        { i(1, "n"), i(2, "N") }
      ),
    })
  ),
}
