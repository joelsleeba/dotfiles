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

  -- Define tilde snippet for tilde accent
  s(
    { trig = "tilde(%w)", desc = "single character tilde accent", regTrig = true, wordTrig = false },
    fmta(
      [[
        \tilde{<>}
      ]],
      { f(function(_, snip)
        return snip.captures[1]
      end) }
    )
  ),

  -- Define hat snippet for hat accent
  s(
    { trig = "hat(%w)", desc = "single character hat accent", regTrig = true, wordTrig = false },
    fmta(
      [[
        \hat{<>}
      ]],
      { f(function(_, snip)
        return snip.captures[1]
      end) }
    )
  ),

  -- Define acute snippet for acute accent
  s(
    { trig = "acute(%w)", desc = "single character acute accent", regTrig = true, wordTrig = false },
    fmta(
      [[
        \acute{<>}
      ]],
      { f(function(_, snip)
        return snip.captures[1]
      end) }
    )
  ),

  -- Define bar snippet bar accent
  s(
    { trig = "bar(%w)", desc = "single character bar accent", regTrig = true, wordTrig = false },
    fmta(
      [[
        \bar{<>}
      ]],
      { f(function(_, snip)
        return snip.captures[1]
      end) }
    )
  ),

  -- Define dot snippet dot accent
  s(
    { trig = "([^%a])dot(%w)", desc = "single character dot accent", regTrig = true, wordTrig = false },
    fmta(
      [[
        \dot{<>}
      ]],
      { f(function(_, snip)
        return snip.captures[2]
      end) }
    )
  ),

  -- Define ddot snippet ddot accent
  s(
    { trig = "ddot(%w)", desc = "single character ddot accent", regTrig = true, wordTrig = false },
    fmta(
      [[
        \ddot{<>}
      ]],
      { f(function(_, snip)
        return snip.captures[1]
      end) }
    )
  ),

  -- Define bb snippet which expands to blackboard letters
  s(
    { trig = "([^%a])bb(%w)", desc = "blackboard letter", regTrig = true, wordTrig = false },
    fmta(
      [[
        \mathbb{<>}
      ]],
      { f(function(_, snip)
        return snip.captures[2]
      end) }
    )
  ),

  -- Define scr snippet which expands to script letters
  s(
    { trig = "([^%a])scr(%w)", desc = "script letter", regTrig = true, wordTrig = false },
    fmta(
      [[
        \mathscr{<>}
      ]],
      { f(function(_, snip)
        return snip.captures[2]
      end) }
    )
  ),

  -- Define cal snippet which expands to calligraphy letters
  s(
    { trig = "([^%a])cal(%w)", desc = "calligraphy letter", regTrig = true, wordTrig = false },
    fmta(
      [[
        \mathcal{<>}
      ]],
      { f(function(_, snip)
        return snip.captures[2]
      end) }
    )
  ),

  -- Define frak snippet which expands to fraktur letters
  s(
    { trig = "([^%a])frak(%w)", desc = "fraktur letter", regTrig = true, wordTrig = false },
    fmta(
      [[
        \mathfrak{<>}
      ]],
      { f(function(_, snip)
        return snip.captures[2]
      end) }
    )
  ),

  -- Define big snippet complement big
  s(
    { trig = "big", desc = "big style", regTrig = false, wordTrig = true },
    fmta(
      [[
        \big <> \big
      ]],
      { i(1) }
    )
  ),

  -- Define bigg snippet for bigg equation style
  s(
    { trig = "bigg", desc = "bigg style", regTrig = false, wordTrig = true },
    fmta(
      [[
        \bigg <> \bigg
      ]],
      { i(1) }
    )
  ),

  -- Define Big snippet for Big equation style
  s(
    { trig = "Big", desc = "Big style", regTrig = false, wordTrig = true },
    fmta(
      [[
        \Big <> \Big
      ]],
      { i(1) }
    )
  ),

  -- Define Bigg snippet for Bigg equation style
  s(
    { trig = "Bigg", desc = "Bigg style", regTrig = false, wordTrig = true },
    fmta(
      [[
        \Bigg <> \Bigg
      ]],
      { i(1) }
    )
  ),
}
