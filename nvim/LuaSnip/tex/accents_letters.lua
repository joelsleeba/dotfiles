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
    { trig = "([^%a])til", desc = "single character tilde accent", trigEngine = "pattern", wordTrig = false },
    fmta(
      [[
        <>\tilde{<>}
      ]],
      { f(function(_, snip)
        return snip.captures[1]
      end), i(1) }
    )
  ),

  -- Define hat snippet for hat accent
  s(
    { trig = "([^%a])hat", desc = "hat accent", trigEngine = "pattern", wordTrig = false },
    fmta(
      [[
        <>\hat{<>}
      ]],
      { f(function(_, snip)
        return snip.captures[1]
      end), i(1) }
    )
  ),

  -- Define what snippet for widehat accent
  s(
    { trig = "([^%a])what", desc = "wide hat accent", trigEngine = "pattern", wordTrig = false },
    fmta(
      [[
        <>\widehat{<>}
      ]],
      { f(function(_, snip)
        return snip.captures[1]
      end), i(1) }
    )
  ),

  -- Define acute snippet for acute accent
  s(
    { trig = "acute(%w)", desc = "single character acute accent", trigEngine = "pattern", wordTrig = false },
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
    { trig = "bar", desc = "bar accent", trigEngine = "plain", wordTrig = true },
    fmta(
      [[
        \bar{<>}
      ]],
      {
        i(1),
      }
    )
  ),

  -- Define ol snippet for overline
  s(
    { trig = "([^%a])ol", desc = "overline", trigEngine = "pattern", wordTrig = false },
    fmta(
      [[
        <>\overline{<>}
      ]],
      { f(function(_, snip)
        return snip.captures[1]
      end), i(1) }
    )
  ),

  -- Define dot snippet dot accent
  s(
    { trig = "([^%a])dot", desc = "single character dot accent", trigEngine = "pattern", wordTrig = false },
    fmta(
      [[
        <>\dot{<>}
      ]],
      {
        f(function(_, snip)
          return snip.captures[1]
        end),
        i(1),
      }
    )
  ),

  -- Define ddot snippet ddot accent
  s(
    { trig = "([^%a])ddot", desc = "single character ddot accent", trigEngine = "pattern", wordTrig = false },
    fmta(
      [[
        <>\ddot{<>}
      ]],
      {
        f(function(_, snip)
          return snip.captures[1]
        end),
        i(1),
      }
    )
  ),

  -- Define snippet for superscript
  s(
    { trig = "([^%s]+)^", desc = "superscript", trigEngine = "pattern", wordTrig = false },
    fmta(
      [[
        <>^{<>}
      ]],
      { f(function(_, snip)
        return snip.captures[1]
      end), i(1) }
    )
  ),

  -- Define snippet for subscript
  s(
    { trig = "([^%s]+)_", desc = "subscript", trigEngine = "pattern", wordTrig = false },
    fmta(
      [[
        <>_{<>}
      ]],
      { f(function(_, snip)
        return snip.captures[1]
      end), i(1) }
    )
  ),

  -- Define snippet for prime accent
  s(
    { trig = "([^%s]+)'", desc = "prime accent", trigEngine = "pattern", wordTrig = false },
    fmta(
      [[
        <>^\prime
      ]],
      { f(function(_, snip)
        return snip.captures[1]
      end) }
    )
  ),

  -- Define bb snippet which expands to blackboard letters
  s(
    { trig = "bb", desc = "blackboard letter", trigEngine = "plain", wordTrig = true },
    fmta(
      [[
        \mathbb{<>}
      ]],
      {
        i(1),
      }
    ),
    {
      callbacks = {
        -- index `-1` means the callback is on the snippet as a whole
        [-1] = {
          [events.leave] = function()
            vim.cmd([[
            autocmd InsertCharPre <buffer> ++once lua _G.if_char_insert_space()
          ]])
          end,
        },
      },
    }
  ),

  -- Define bf snippet for textbf
  s({ trig = "bf", desc = "boldface letters", trigEngine = "plain", wordTrig = true }, fmta("\\textbf{<>}", { i(1) })),

  -- Define it snippet for textit
  s({ trig = "it", desc = "italic letters", trigEngine = "plain", wordTrig = true }, fmta("\\textit{<>}", { i(1) })),

  -- Define rm snippet for textrm
  s({ trig = "rm", desc = "roman letters", trigEngine = "plain", wordTrig = true }, fmta("\\textrm{<>}", { i(1) })),

  -- Define scr snippet which expands to script letters
  s(
    { trig = "scr", desc = "script letter", trigEngine = "plain", wordTrig = true },
    fmta(
      [[
        \mathscr{<>}
      ]],
      {
        i(1),
      }
    )
  ),

  -- Define cal snippet which expands to calligraphy letters
  s(
    { trig = "cal", desc = "calligraphy letter", trigEngine = "plain", wordTrig = true },
    fmta(
      [[
        \mathcal{<>}
      ]],
      {
        i(1),
      }
    )
  ),

  -- Define frak snippet which expands to fraktur letters
  s(
    { trig = "frak", desc = "fraktur letter", trigEngine = "plain", wordTrig = true },
    fmta(
      [[
        \mathfrak{<>}
      ]],
      {
        i(1),
      }
    )
  ),

  -- Define b( snippet that expands to big parenthesis
  s({ trig = "b(", desc = "big parenthesis", trigEngine = "plain", wordTrig = true }, fmta("\\big(<>\\big)", { i(1) })),

  -- Define B( snippet that expands to big parenthesis
  s({ trig = "B(", desc = "Big parenthesis", trigEngine = "plain", wordTrig = true }, fmta("\\Big(<>\\Big)", { i(1) })),

  -- Define b{ snippet that expands to big curly braces
  s(
    { trig = "b{", desc = "big curly braces", trigEngine = "plain", wordTrig = true },
    fmta("\\big\\{<>\\big\\}", { i(1) })
  ),

  -- Define B{ snippet that expands to big curly braces
  s(
    { trig = "B{", desc = "Big curly braces", trigEngine = "plain", wordTrig = true },
    fmta("\\Big\\{<>\\Big\\}", { i(1) })
  ),
}
