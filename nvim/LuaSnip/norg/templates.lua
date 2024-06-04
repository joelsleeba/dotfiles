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
local util = require("luasnip.util.util")
local node_util = require("luasnip.nodes.util")

local gym = function(args, snip)
  local day = args[1][1]

  local nodes = {}

  if day == "rest" then
    return sn(nil, nodes)
  end

  table.insert(nodes, t({ "* Gym Routine", "" }))

  if day == "leg" then
    table.insert(nodes, t({ "  Barbell Squats  - 6x10kg + 6x15kg + 8x20kg + 8x15kg", "" }))
    table.insert(nodes, t({ "  Hamstring Curls - 6x20kg + 6x25kg + 8x25kg + 4x30kg", "" }))
    table.insert(nodes, t({ "  Leg Raise       - 6x20kg + 6x25kg + 6x30kg + 6x35kg", "" }))
    table.insert(nodes, t({ "  Calf Raise      - 6x20kg + 6x40kg + 8x40kg + 6x50kg", "" }))
    table.insert(nodes, t({ "  Leg Press       - 6x40kg + 6x50kg + 8x50kg + 6x60kg", "" }))
  elseif day == "push" then
    table.insert(nodes, t({ "  Bench Press               - 8x10kg + 4x15kg + 4x15kg + 5x10kg", "" }))
    table.insert(nodes, t({ "  Cable Incline Bench Press - 12x5kg + 12x10kg + 8x15kg + 8x15kg", "" }))
    table.insert(nodes, t({ "  Cable Chest Press         - 8x10kg + 4x20kg + 10x15kg + 7x15kg", "" }))
    table.insert(nodes, t({ "  Tricep Push Down          - 12x15kg + 9x20kg + 7x20kg + 6x20kg", "" }))
    table.insert(nodes, t({ "  Pectoral Fly              - 8x20kg + 8x25kg + 6x30kg", "" }))
    table.insert(nodes, t({ "  Leg Lifts", "" }))
    table.insert(nodes, t({ "  Shoulder Push             - 8x2.5kg + 8x5kg + 6x7.5kg + 4x7.5kg", "" }))
  elseif day == "pull" then
    table.insert(nodes, t({ "  Curlbar Deadlift - 6x7.5kg + 6x10kg + 8x10kg + 6x15kg", "" }))
    table.insert(nodes, t({ "  Lat Pulldown     - 6x20kg + 6x25kg + 8x25kg + 6x30kg", "" }))
    table.insert(nodes, t({ "  Face Pulls       - 6x10kg + 6x15kg + 8x15kg + 6x20kg", "" }))
    table.insert(nodes, t({ "  Bicep Curls      - 6x0kg + 6x2.5kg + 8x5kg + 6x5kg", "" }))
  end

  return sn(nil, nodes)
end

local pending_goals = function(_, snip)
  fpath = vim.fn.expand("%")
  _, _, y, m, d = string.find(fpath, "(%d+)/(%d+)/(%d+)")
  offset = os.time() - os.time(os.date("!*t"))
  epoch_day_before = os.time({ day = d, month = m, year = y }) - 24 * 60 * 60 + offset

  -- replace the hard link with something from neorg.core.journal.path or similar
  yester_journal_path = "/home/joel/workspace/NotesHome/neorg/journal/"
    .. os.date("%Y/%m/%d", epoch_day_before)
    .. ".norg"
  yester_journal, err = io.open(yester_journal_path, "r")

  pending_goals = {}
  if yester_journal then
    for line in yester_journal:lines() do
      if string.find(line, "- %( %)") then
        print(line)
        table.insert(pending_goals, line)
      end
    end
  else
    print(err)
    return nil
  end

  yester_journal:close()
  return pending_goals
end

local day_mode = function(args, snip)
  local mode = args[1][1]

  local nodes = {}

  if mode == "work" then
    table.insert(nodes, t({ "* Work", "" }))
    table.insert(nodes, t({ "** Research", "" }))
    table.insert(nodes, t({ "   " }))
    table.insert(nodes, i(1, ""))
    table.insert(nodes, t({ "", "" }))
  elseif mode == "wander" then
    table.insert(nodes, t({ "* Pioneer", "" }))
    table.insert(nodes, t({ "** New topic exposure", "   " }))
    table.insert(nodes, i(1, ""))
    table.insert(nodes, t({ "", "" }))
    table.insert(nodes, t({ "** New research updates", "   " }))
    table.insert(nodes, i(2, ""))
    table.insert(nodes, t({ "", "" }))
    table.insert(nodes, t({ "** Blog articles", "   " }))
    table.insert(nodes, i(3, ""))
    table.insert(nodes, t({ "", "" }))
  elseif mode == "rest" then
    table.insert(nodes, t({ "* Rest Schenanigans", "" }))
    table.insert(nodes, t({ "** Meeting People", "   " }))
    table.insert(nodes, i(1, ""))
    table.insert(nodes, t({ "", "" }))
    table.insert(nodes, t({ "** Movie Time", "   " }))
    table.insert(nodes, i(2, ""))
    table.insert(nodes, t({ "", "" }))
  end
  table.insert(nodes, t({ "", "" }))

  table.insert(nodes, t({ "* Day Analysis", "" }))
  table.insert(nodes, t({ "** Nice things", "   " }))
  table.insert(nodes, i(1, ""))
  table.insert(nodes, t({ "", "" }))
  table.insert(nodes, t({ "** Bad things", "   " }))
  table.insert(nodes, i(2, ""))
  table.insert(nodes, t({ "", "" }))
  table.insert(nodes, t({ "** Observations", "   " }))
  table.insert(nodes, i(3, ""))
  table.insert(nodes, t({ "", "" }))

  return sn(nil, nodes)
end

return {

  -- Define journal snippet for journal entry
  s(
    { trig = "journal", desc = "letter property snippet for letters" },
    fmta(
      [[
        @document.meta
        title: Journal - <>
        created: <>, <>
        mode : <>
        gym : <>
        @end

        * ( ) Goals
        <>
          - ( ) <>
          - ( ) <>
          - ( ) <>

        <>
        <>
      ]],
      {
        f(function(_, snip)
          fpath = vim.fn.expand("%")
          _, _, y, m, d = string.find(fpath, "(%d+)/(%d+)/(%d+)")
          offset = os.time() - os.time(os.date("!*t"))
          epoch = os.time({ day = d, month = m, year = y }) + offset
          return os.date("%d, %b %Y", epoch)
        end),
        f(function(_, snip)
          return os.date("%Y-%m-%d", os.time())
        end),
        f(function(_, snip)
          return os.date("%H:%M", os.time())
        end),
        c(1, {
          t("work"),
          t("wander"),
          t("rest"),
        }),
        c(2, {
          t("leg"),
          t("push"),
          t("pull"),
          t("full body"),
          t("rest"),
        }),
        f(pending_goals),
        i(3, "Goal"),
        i(4, "Goal"),
        i(5, "Goal"),
        d(6, day_mode, { 1 }, {}),
        d(7, gym, { 2 }, {}),
      }
    )
  ),

  -- Define pending_goals snippet updates current goals with pending goals
  s(
    {
      trig = "pending_goals",
      desc = "add pending goals to current journal goals",
      trigEngine = "plain",
      wordTrig = true,
    },
    fmta(
      [[
        <>
      ]],
      { f(pending_goals) }
    )
  ),
}
