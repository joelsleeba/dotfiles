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

-- function for the dynamicNode which deals with the number of items in list
local list = function(args, snip)
  -- snip.rows will not be set by default, so handle that case.
  -- it's also the value set by the functions called from dynamic_node_external_update().
  if not snip.rows then
    snip.rows = 1
  end
  local nodes = {}

  -- keep track of which insert-index we're at.
  local ins_indx = 1
  for j = 1, snip.rows do
    table.insert(nodes, t("  - [ ]"))
    -- use restoreNode to not lose content when updating.
    table.insert(nodes, r(ins_indx, tostring(j), i(1)))
    ins_indx = ins_indx + 1

    table.insert(nodes, t({ "", "" }))
  end

  -- fix last node.
  nodes[#nodes] = t("")
  return sn(nil, nodes)
end

return {
  -- Define code snippet for code block
  s(
    { trig = "code", desc = "code block", trigEngine = "plain", wordTrig = true, snippetType = snippet },
    fmta(
      [[
        ``` <>
          <>
        ```
      ]],
      { i(1, "language"), i(2, "code") }
    )
  ),

  -- Define ls snippet for making dynamic list
  -- Use <c-t> and <c-g> as defined in luasnip.lua change the no.of items
  s(
    { trig = "ls", desc = "list" },
    fmta(
      [[
        <>
      ]],
      {
        d(1, list, { 1 }, {
          user_args = {
            -- Pass the functions used to manually update the dynamicNode as user args.
            -- The n-th of these functions will be called by dynamic_node_external_update(n).
            -- These functions are pretty simple, there's probably some cool stuff one could do
            -- with `ui.input`
            function(snip)
              snip.rows = snip.rows + 1
            end,
            -- don't drop below one.
            function(snip)
              snip.rows = math.max(snip.rows - 1, 1)
            end,
          },
        }),
      }
    )
  ),

  -- Define table snippet for table
  s({ trig = "table(%d+)x(%d+)", regTrig = true }, {
    d(1, function(args, snip)
      local nodes = {}
      local i_counter = 0
      local hlines = ""
      for _ = 1, snip.captures[2] do
        i_counter = i_counter + 1
        table.insert(nodes, t("| "))
        table.insert(nodes, i(i_counter, "Column" .. i_counter))
        table.insert(nodes, t(" "))
        hlines = hlines .. "|---"
      end
      table.insert(nodes, t({ "|", "" }))
      hlines = hlines .. "|"
      table.insert(nodes, t({ hlines, "" }))
      for _ = 1, snip.captures[1] do
        for _ = 1, snip.captures[2] do
          i_counter = i_counter + 1
          table.insert(nodes, t("| "))
          table.insert(nodes, i(i_counter))
          print(i_counter)
          table.insert(nodes, t(" "))
        end
        table.insert(nodes, t({ "|", "" }))
      end
      return sn(nil, nodes)
    end),
  }),
}
