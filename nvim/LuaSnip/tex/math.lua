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

-- imports visual selection for snippet handling
local get_visual = function(args, parent)
  if #parent.snippet.env.LS_SELECT_RAW > 0 then
    return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
  else -- If LS_SELECT_RAW is empty, return a blank insert node
    return sn(nil, i(1))
  end
end

return {
  -- trigger Euler's constant
  s(
    { trig = "([^%a])ee", desc = "Euler's constant", regTrig = true, wordTrig = false },
    fmt("<>e^{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
    }, { delimiters = "<>" })
  ),

  -- Define fr snippet which expands to a fraction
  s(
    { trig = "([^%a])fr", desc = "fraction", regTrig = true, wordTrig = false },
    fmt([[<>\frac{<>}{<>}]], {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
      i(2),
    }, { delimiters = "<>" })
  ),

  -- Define ip snippet which expands to an inner product
  s(
    { trig = "([^%a])ip", desc = "inner product", regTrig = true, wordTrig = false },
    fmt([[<>\langle <> , <> \rangle ]], {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
      i(2),
    }, { delimiters = "<>" })
  ),

  -- Define lim snippet which expands to a limit
  s(
    { trig = "lim", dscr = "Expands limit as variable tend to value", priority = 1000 },
    fmta(
      [[
        \lim_{<> \to <>} <>(<>)
      ]],
      { i(1, "n"), i(2, "\\infty"), i(3, "f"), i(4, "x") }
    )
  ),

  -- Define set snippet which expands to a set builder form
  s(
    { trig = "set", dscr = "set braces", priority = 1000 },
    c(1, {
      sn(nil, { t("\\{ "), i(1), t("  |  "), i(2), t(" \\}") }),
      sn(nil, { t("\\{ "), i(1), t(" \\}") }),
    })
  ),

  -- Define sum snippet which expands to latex code for summation
  s(
    { trig = "sum", dscr = "sum over a variable", priority = 1000 },
    fmta(
      [[
          \sum_{<>}^{<>} <>
        ]],
      { i(1, "i"), i(2, "n"), i(3, "f(n)") }
    )
  ),
}
