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

  -- Define snip_header snippet for snippet file header
  s(
    { trig = "snip_header", desc = "snippet file header" },
    fmta(
      [[
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
        <>
      }
      ]],
      { i(1) }
    )
  ),

  -- Define snip snippet which extends to a snippets form
  s({ trig = "snip", dscr = "snippet to snippet" }, {
    c(1, {
      sn(nil, {
        t("  -- Define "),
        i(1),
        t(" snippet which "),
        i(2),
        t({ "", 's( "' }),
        i(3),
        t('", { t("'),
        i(4),
        t('") } ),'),
      }),
      sn(
        nil,
        fmta(
          [[
          -- Define <> snippet <>
          s({ trig = "<>", desc = "<>", trigEngine = "<>", wordTrig = <> },
            <>
          ),
          ]],
          {
            i(1, "snip"),
            i(2, "that does snip job"),
            i(3, "trigger"),
            i(4, "description"),
            c(5, {
              t("plain"),
              t("pattern"),
              t("ecma"),
            }),
            c(6, {
              t("true"),
              t("false"),
            }),
            i(7),
          }
        )
      ),
    }),
  }),

  -- Define fmta snippet which extends to the fmta function
  s({ trig = "fmta", dscr = "fmta", priority = 1000 }, {
    c(1, {
      sn(nil, {
        t({ "fmta(", "  [[", "    " }),
        i(1),
        t({ "", "  ]],", "  { " }),
        i(2, "i(1)"),
        t({ " }", ")" }),
      }),
      sn(nil, fmta('fmta("<>", { <> })', { i(1), i(2, "i(1)") })),
    }),
  }),

  -- Define c_node snippet which extends to a choice node in lua
  s(
    { trig = "c_node", dscr = "choice node", priority = 1000 },
    fmta(
      [[
      c(<>, {
        <>
      })
      ]],
      { i(1, "1"), i(2) }
    )
  ),

  -- Define sn_node snippet which extends to a snippet node in lua
  s(
    { trig = "sn_node", dscr = "snippet node", priority = 1000 },
    fmta(
      [[
      sn(<>,
        <>
      ),
      ]],
      { i(1, "nil"), i(2) }
    )
  ),

  -- Define return snippet for lua return
  s(
    { trig = "return", dscr = "return", priority = 1000 },
    fmta(
      [[
      return {
        <>
      }
      ]],
      { i(1) }
    )
  ),
}
