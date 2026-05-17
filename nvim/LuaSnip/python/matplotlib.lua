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
  -- Define ax snippet for axis
  s(
    { trig = "ax", desc = "plt.axis", trigEngine = "plain", wordTrig = true, snippetType = snippet },
    c(1, {
      sn(
        nil,
        fmta(
          [[
            plt.axhline(<>, color="<>", linewidth=<>)
          ]],
          { i(1, "0"), i(2, "gray"), i(3, "0.5") }
        )
      ),
      sn(
        nil,
        fmta(
          [[
            plt.axvline(<>, color="<>", linewidth=<>)
          ]],
          { i(1, "0"), i(2, "gray"), i(3, "0.5") }
        )
      ),
    })
  ),

  -- Define hist snippet for histogram
  s(
    { trig = "hist", desc = "plt.histogram", trigEngine = "plain", wordTrig = true, snippetType = snippet },
    fmta(
      [[
      plt.hist(
          <>,
          bins=<>,
          density=<>,
          color="<>",
          edgecolor="<>",
      )
      ]],
      {
        i(1, "data"),
        i(2, "15"),
        c(3, {
          t("True"),
          t("False"),
        }),
        i(4, "lightblue"),
        i(5, "black"),
      }
    )
  ),

  -- Define label snippet for label
  s(
    { trig = "label", desc = "plt.label", trigEngine = "plain", wordTrig = true, snippetType = snippet },
    c(1, {
      sn(
        nil,
        fmta(
          [[
            plt.xlabel(<>)
          ]],
          { i(1, "0") }
        )
      ),
      sn(
        nil,
        fmta(
          [[
            plt.ylabel(<>)
          ]],
          { i(1, "0") }
        )
      ),
    })
  ),

  -- Define scatter snippet for scatterplot
  s(
    { trig = "scatter", desc = "plt.scatter", trigEngine = "plain", wordTrig = true, snippetType = snippet },
    fmta(
      [[
        plt.scatter(<>, <>, s=<>, alpha=<>, color="<>")
      ]],
      { i(1, "x-coordinates"), i(2, "y-coordinates"), i(3, "2"), i(4, "0.35"), i(5, "navy") }
    )
  ),

  -- Define scatterplot snippet for scatterplot
  s(
    { trig = "scatterplot", desc = "scatterplot", trigEngine = "plain", wordTrig = true, snippetType = snippet },
    fmta(
      [[
        plt.figure(figsize=(<>, <>))

        plt.scatter(<>, <>, s=<>, alpha=0.35, color="<>")
        
        plt.axhline(0, color="gray", linewidth=0.5)
        plt.axvline(0, color="gray", linewidth=0.5)
        
        plt.xlabel(rf"$<>$")
        plt.ylabel(rf"$<>$")
        plt.title(rf"<>")
        
        plt.grid(alpha=0.2)
        plt.axis("equal")
        plt.tight_layout()
        plt.show()

      ]],
      {
        i(1, "5"),
        i(2, "5"),
        i(3, "x-coordinate values"),
        i(4, "y-coordinate values"),
        i(5, "2"),
        i(6, "navy"),
        i(7, "x-label"),
        i(8, "y-label"),
        i(9, "title"),
      }
    )
  ),
}
