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

-- To insert space if the character after the snippet exapnsion is a letter
_G.if_char_insert_space = function()
  if string.find(vim.v.char, "%a") then
    vim.v.char = " " .. vim.v.char
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

  -- Define \0 snippet expands to \emptyset
  s(
    { trig = "\\0", desc = "emptyset", trigEngine = "plain", wordTrig = true, snippetType = "autosnippet" },
    fmta("\\emptyset", {}),
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

  -- Define \8 snippet expands to \infty
  s(
    { trig = "\\8", desc = "infty", trigEngine = "plain", wordTrig = true, snippetType = "autosnippet" },
    fmta("\\infty", {}),
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

  -- Define \- snippet expands to \setminus
  s(
    { trig = "\\-", desc = "setminus", trigEngine = "plain", wordTrig = true, snippetType = "autosnippet" },
    fmta("\\setminus", {}),
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

  -- Define ... snippet expands to \ldots
  s(
    { trig = "...", desc = "lower dots", trigEngine = "plain", wordTrig = true, snippetType = "autosnippet" },
    fmta("\\ldots", {}),
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

  -- Define cap snippet that expands to an intersection
  s(
    { trig = "cap", desc = "union", trigEngine = "plain", wordTrig = true },
    c(1, {
      sn(nil, fmta("\\cap_{<> = <>}^{<>}", { i(1, "n"), i(2, "1"), i(3, "\\infty") })),
      sn(nil, fmta("\\cap_{<> \\in <>}", { i(1, "n"), i(2, "\\mathbb{N}") })),
    })
  ),

  -- Define bcap snippet that expands to a big intersection
  s(
    { trig = "bcap", desc = "big intersection", trigEngine = "plain", wordTrig = true },
    c(1, {
      sn(nil, fmta("\\bigcap_{<> = <>}^{<>}", { i(1, "n"), i(2, "1"), i(3, "\\infty") })),
      sn(nil, fmta("\\bigcap_{<> \\in <>}", { i(1, "n"), i(2, "\\mathbb{N}") })),
    })
  ),

  -- Define cup snippet that expands to a union
  s(
    { trig = "cup", desc = "union", trigEngine = "plain", wordTrig = true },
    c(1, {
      sn(nil, fmta("\\cup_{<> = <>}^{<>}", { i(1, "n"), i(2, "1"), i(3, "\\infty") })),
      sn(nil, fmta("\\cup_{<> \\in <>}", { i(1, "n"), i(2, "\\mathbb{N}") })),
    })
  ),

  -- Define bcup snippet that expands to a big union
  s(
    { trig = "bcup", desc = "big union", trigEngine = "plain", wordTrig = true },
    c(1, {
      sn(nil, fmta("\\bigcup_{<> = <>}^{<>}", { i(1, "n"), i(2, "1"), i(3, "\\infty") })),
      sn(nil, fmta("\\bigcup_{<> \\in <>}", { i(1, "n"), i(2, "\\mathbb{N}") })),
    })
  ),

  -- Define inf snippet that expands to a infimum
  s(
    { trig = "inf", desc = "infimum", trigEngine = "plain", wordTrig = true },
    c(1, {
      sn(nil, fmta("\\inf{<> = <>}^{<>}", { i(1, "n"), i(2, "1"), i(3, "\\infty") })),
      sn(nil, fmta("\\inf{<> \\in <>}", { i(1, "n"), i(2, "\\mathbb{N}") })),
    })
  ),

  -- Define sup snippet that expands to a supremum
  s(
    { trig = "sup", desc = "supremum", trigEngine = "plain", wordTrig = true },
    c(1, {
      sn(nil, fmta("\\sup_{<> = <>}^{<>}", { i(1, "n"), i(2, "1"), i(3, "\\infty") })),
      sn(nil, fmta("\\sup_{<> \\in <>}", { i(1, "n"), i(2, "\\mathbb{N}") })),
    })
  ),

  -- Define inv snippet that expands to inverse
  s(
    { trig = "([^%s])inv", desc = "inverse", trigEngine = "pattern", wordTrig = false },
    fmta(
      [[
        <>^{-1}
      ]],
      { f(function(_, snip)
        return snip.captures[1]
      end) }
    )
  ),

  -- Define / snippet which expands to a fraction
  s(
    { trig = "(%s)(%g+)/(%g+)", desc = "fraction", regTrig = true, wordTrig = false },
    fmt([[<>\frac{<>}{<>}]], {
      f(function(_, snip)
        return snip.captures[1]
      end),
      f(function(_, snip)
        return snip.captures[2]
      end),
      f(function(_, snip)
        return snip.captures[3]
      end),
    }, { delimiters = "<>" })
  ),

  -- An alternative snippet for fractions when the denominator is yet to be filled. Later with knowledge combine this with the above snippet using subsnippets
  s(
    { trig = "(%s)(%g+)/", desc = "fraction", regTrig = true, wordTrig = false },
    fmt([[<>\frac{<>}{<>}]], {
      f(function(_, snip)
        return snip.captures[1]
      end),
      f(function(_, snip)
        return snip.captures[2]
      end),
      i(1),
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
      sn(nil, { t("\\{ "), i(1), t(" \\}") }),
      sn(nil, { t("\\{ "), i(1), t("  \\ : \\  "), i(2), t(" \\}") }),
    })
  ),

  -- Define sum snippet that expands to a summation
  s(
    { trig = "sum", desc = "summation", trigEngine = "pattern", wordTrig = true },
    c(1, {
      sn(
        nil,
        fmta("\\sum_{<> \\in <>} <>", {
          -- f(function(_, snip)
          --   return snip.captures[1]
          -- end),
          i(1, "n"),
          i(2, "\\mathbb{N}"),
          i(3, "a_n"),
        })
      ),
      sn(
        nil,
        fmta("\\sum_{<> = <>}^{<>} <>", {
          -- f(function(_, snip)
          --   return snip.captures[1]
          -- end),
          i(1, "i"),
          i(2, "1"),
          i(3, "n"),
          i(4, "a_n"),
        })
      ),
    })
  ),

  -- Define trace snippet which expands to a trace
  s(
    { trig = "trace", desc = "trace" },
    fmta(
      [[
        \rm{trace}(<>)
      ]],
      { i(1) }
    )
  ),

  -- Define norm snippet which expands to the norm expression
  s(
    { trig = "norm", desc = "norm", regTrig = false, wordTrig = true },
    fmta(
      [[
        \|<>\|
      ]],
      { i(1) }
    )
  ),

  -- Define | snippet expands to absolute value
  s({ trig = "|", desc = "absolute value", trigEngine = "plain", wordTrig = true }, fmta("|<>|", { i(1) })),
}
