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
  -- Define ar snippet for right arrow
  s(
    { trig = "ar", desc = "right arrow", trigEngine = "plain", wordTrig = true, snippetType = snippet },
    fmta(
      [[
        \rightarrow
      ]],
      {}
    )
  ),

  -- Define al snippet for left arrow
  s(
    { trig = "al", desc = "left arrow", trigEngine = "plain", wordTrig = true, snippetType = snippet },
    fmta(
      [[
        \leftarrow
      ]],
      {}
    )
  ),

  -- Define au snippet for up arrow
  s(
    { trig = "au", desc = "up arrow", trigEngine = "plain", wordTrig = true, snippetType = snippet },
    fmta(
      [[
        \uparrow
      ]],
      {}
    )
  ),

  -- Define ad snippet for down arrow
  s(
    { trig = "ad", desc = "down arrow", trigEngine = "plain", wordTrig = true, snippetType = snippet },
    fmta(
      [[
        \downarrow
      ]],
      {}
    )
  ),

  -- Define alr snippet for left-right arrow
  s(
    { trig = "alr", desc = "left-right arrow", trigEngine = "plain", wordTrig = true, snippetType = snippet },
    fmta(
      [[
        \leftrightarrow
      ]],
      {}
    )
  ),

  -- Define aud snippet for up-down arrow
  s(
    { trig = "aud", desc = "up-down arrow", trigEngine = "plain", wordTrig = true, snippetType = snippet },
    fmta(
      [[
        \updownarrow
      ]],
      {}
    )
  ),

  -- Define ane snippet for north-east arrow
  s(
    { trig = "ane", desc = "north-east arrow", trigEngine = "plain", wordTrig = true, snippetType = snippet },
    fmta(
      [[
        \nearrow
      ]],
      {}
    )
  ),

  -- Define anw snippet for north-west arrow
  s(
    { trig = "anw", desc = "north-west arrow", trigEngine = "plain", wordTrig = true, snippetType = snippet },
    fmta(
      [[
        \nwarrow
      ]],
      {}
    )
  ),

  -- Define ase snippet for south-east arrow
  s(
    { trig = "ase", desc = "south-east arrow", trigEngine = "plain", wordTrig = true, snippetType = snippet },
    fmta(
      [[
        \searrow
      ]],
      {}
    )
  ),

  -- Define asw snippet for south-west arrow
  s(
    { trig = "asw", desc = "south-west arrow", trigEngine = "plain", wordTrig = true, snippetType = snippet },
    fmta(
      [[
        \swarrow
      ]],
      {}
    )
  ),
}
