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
  -- Define fn snippet for function
  s(
    { trig = "fn", desc = "function", trigEngine = "plain", wordTrig = true, snippetType = snippet },
    fmta(
      [[
        def <>(<>):
          <>
      ]],
      { i(1, "foo"), i(2, "args"), i(3, "pass") }
    )
  ),

  -- Define for snippet for for loop
  s(
    { trig = "for", desc = "for loop", trigEngine = "plain", wordTrig = true, snippetType = snippet },
    fmta(
      [[
        for <> in <>:
          <>
      ]],
      { i(1, "i"), i(2, "range()"), i(3, "pass") }
    )
  ),

  -- Define rn snippet for range
  s(
    { trig = "rn([%w]+)", desc = "range", trigEngine = "plain", wordTrig = true, snippetType = snippet },
    fmta(
      [[
        range(<>)
      ]],
      {
        f(function(_, snip)
          if not snip.captures[1] == "" then
            return snip.captures[1]
          else
            local nodes = {}
            table.insert(nodes, i(1))
            table.insert(nodes, t(","))
            table.insert(nodes, i(2))
            table.insert(nodes, t(","))
            table.insert(nodes, i(3))
          end
        end),
      }
    )
  ),
}
