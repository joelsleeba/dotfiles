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

  -- Define \l snippet for \ell
  s(
    { trig = "\\l", desc = "\\ell", trigEngine = "plain", wordTrig = true },
    c(1, {
      sn(
        nil,
        fmta(
          [[
            \ell^{<>}(<>)
          ]],
          {
            i(1, "2"),
            i(2),
          }
        )
      ),
      sn(
        nil,
        fmta(
          [[
            \ell^{<>}
          ]],
          { i(1) }
        )
      ),
    })
  ),

  -- Define \L snippet for L^p
  s(
    { trig = "\\L", desc = "L^p", trigEngine = "plain", wordTrig = true },
    c(1, {
      sn(
        nil,
        fmta(
          [[
            L^{<>}(<>)
          ]],
          {
            i(1, "2"),
            i(2, "[-\\pi, \\pi]"),
          }
        )
      ),
      sn(
        nil,
        fmta(
          [[
            L^{<>}
          ]],
          { i(1) }
        )
      ),
    })
  ),

  -- Define c0 snippet for \\textbf{c}_0
  s(
    { trig = "c0", desc = "\\textbf{c}_0", trigEngine = "plain", wordTrig = true, snippetType = snippet },
    fmta(
      [[
        \textbf{c}_0
      ]],
      {}
    )
  ),

  -- Define c00 snippet for \\textbf{c}_{00}
  s(
    { trig = "c00", desc = "\\textbf{c}_{00}", trigEngine = "plain", wordTrig = true, snippetType = snippet },
    fmta(
      [[
        \textbf{c}_{00}
      ]],
      {}
    )
  ),

  -- Define ker snippet for Kernel
  s(
    { trig = "ker[a-zA-Z]", desc = "Kernel", trigEngine = "plain", wordTrig = true, snippetType = snippet },
    fmta(
      [[
        \textrm{Ker}(<>)
      ]],
      {
        f(function(_, snip)
          return snip.captures[1]
        end),
      }
    )
  ),

  -- Define ker snippet for Kernel
  s(
    { trig = "ker", desc = "Kernel", trigEngine = "plain", wordTrig = true, snippetType = snippet },
    fmta(
      [[
        \textrm{Ker}(<>)
      ]],
      { i(1) }
    )
  ),

  -- Define polarization snippet for polarization identity
  s(
    {
      trig = " polid",
      desc = "polarization identity",
      trigEngine = "plain",
      wordTrig = true,
      snippetType = snippet,
    },
    fmta(
      [[
        \langle <>, <> \rangle = \frac{1}{4}\sum_{j = 1}^{4} i^j\|<> + i^j <>\|^2, \quad ( i = \sqrt{-1})
      ]],
      { i(1, "h"), i(2, "g"), rep(1), rep(2) }
    )
  ),

  -- Define span snippet for that does snip job
  s(
    { trig = "span", desc = "that does snip job", trigEngine = "plain", wordTrig = true, snippetType = snippet },
    fmta(
      [[
        \textrm{span}
      ]],
      {}
    )
  ),

  -- Define verify snippet for things to verify
  s(
    { trig = "verify", desc = "verify", trigEngine = "plain", wordTrig = true },
    fmta("\\textcolor{red}{<>}", { i(1, "verify") })
  ),
}
