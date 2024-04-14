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
local k = require("luasnip.nodes.key_indexer").new_keyreturn

return {
  s(
    {
      trig = "matrix",
      dscr = "Snippet for certain types of matrix representations",
      priority = 2,
    },
    c(1, {
      sn(
        nil,
        fmta(
          [[
            \begin{<>}
              <>_{11} & <>_{12} & \ldots & <>_{1<>} \\
              <>_{21} & <>_{22} & \ldots & <>_{2<>} \\
              \vdots \\
              <>_{<>1} & <>_{<>2} & \ldots & <>_{<><>}
            \end{<>}
          ]],
          {
            i(1, "b"),
            i(2, "a"),
            rep(2),
            rep(2),
            i(3, "m"),
            rep(2),
            rep(2),
            rep(2),
            rep(3),
            rep(2),
            i(4, "n"),
            rep(2),
            rep(4),
            rep(2),
            rep(4),
            rep(3),
            rep(1),
          }
        )
      ),
      sn(
        nil,
        fmta(
          [[
            \begin{<>matrix}
                      &         & <>_{1<>} &        &\\
                      &         &\vdots  &        &\\
               <>_{<>1} & \ldots  & <>_{<><>}& \ldots & <>_{<><>} \\
                      &         & \vdots &        & \\
                      &         & <>_{<><>} &        &\\
            \end{<>matrix}
          ]],
          {
            i(1, "b"),
            i(2, "a"),
            i(3, "j"),
            rep(2),
            i(4, "i"),
            rep(2),
            rep(4),
            rep(3),
            rep(2),
            rep(4),
            i(5, "m"),
            rep(2),
            i(6, "n"),
            rep(3),
            rep(1),
          }
        )
      ),
    })
  ),

  -- Define smallmatrix snippet for inline matrices
  s(
    { trig = "smatrix", desc = "inline 2x2 small matrix" },
    fmta(
      [[
        \big(\begin{smallmatrix} <> & <> \\ <> & <> \end{smallmatrix} \big)
      ]],
      { i(1, "a"), i(2, "b"), i(3, "c"), i(4, "d") }
    )
  ),
}
