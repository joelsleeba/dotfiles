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

-- To insert space if the character after the snippet exapnsion is a letter
_G.if_char_insert_space = function()
  if string.find(vim.v.char, "%a") then
    vim.v.char = " " .. vim.v.char
  end
end

local function char_count_same(c1, c2)
  local line = vim.api.nvim_get_current_line()
  -- '%'-escape chars to force explicit match (gsub accepts patterns).
  -- second return value is number of substitutions.
  local _, ct1 = string.gsub(line, "%" .. c1, "")
  local _, ct2 = string.gsub(line, "%" .. c2, "")
  return ct1 == ct2
end

local function even_count(c)
  local line = vim.api.nvim_get_current_line()
  local _, ct = string.gsub(line, c, "")
  return ct % 2 == 0
end

local function neg(fn, ...)
  return not fn(...)
end

local function part(fn, ...)
  local args = { ... }
  return function()
    return fn(unpack(args))
  end
end

-- This makes creation of pair-type snippets easier.
local function pair(pair_begin, pair_end, expand_func, ...)
  -- triggerd by opening part of pair, wordTrig=false to trigger anywhere.
  -- ... is used to pass any args following the expand_func to it.
  return s({ trig = pair_begin, wordTrig = true, trigEngine = "plain", snippetType = "autosnippet" }, {
    t({ pair_begin }),
    i(1),
    t({ pair_end }),
  }, {
    condition = part(expand_func, part(..., pair_begin, pair_end)),
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
  })
end

return {
  -- these should be inside your snippet-table.
  pair("(", ")", neg, char_count_same),
  pair("{", "}", neg, char_count_same),
  pair("[", "]", neg, char_count_same),
  -- pair("<", ">", neg, char_count_same),
  pair("'", "'", neg, even_count),
  -- pair("$", "$", neg, even_count),
  pair('"', '"', neg, even_count),
  -- pair("`", "`", neg, even_count),
}
