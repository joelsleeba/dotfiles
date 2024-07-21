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

local function column_count_from_string(descr)
  -- this won't work for all cases, but it's simple to improve
  -- (feel free to do so! :D )
  return #(descr:gsub("[^clm]", ""))
end

-- function for the dynamicNode which deals with the number of table rows
local tab = function(args, snip)
  local cols = column_count_from_string(args[1][1])
  -- snip.rows will not be set by default, so handle that case.
  -- it's also the value set by the functions called from dynamic_node_external_update().
  if not snip.rows then
    snip.rows = 1
  end
  local nodes = {}

  -- keep track of which insert-index we're at.
  local ins_indx = 1
  for j = 1, snip.rows do
    -- use restoreNode to not lose content when updating.
    table.insert(nodes, r(ins_indx, tostring(j) .. "x1", i(1)))
    ins_indx = ins_indx + 1
    for k = 2, cols do
      table.insert(nodes, t(" & "))
      table.insert(nodes, r(ins_indx, tostring(j) .. "x" .. tostring(k), i(1)))
      ins_indx = ins_indx + 1
    end
    table.insert(nodes, t({ "\\\\", "" }))
  end

  -- fix last node.
  nodes[#nodes] = t("")
  return sn(nil, nodes)
end

return {
  -- Define matrix for representative matrices
  s(
    {
      trig = "matrix",
      dscr = "Snippet for representative matrices",
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
            c(1, {
              t("pmatrix"),
              t("bmatrix"),
            }),
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

  -- Define mat snippet for writing the whole matrix
  s(
    { trig = "mat", desc = "matrix with all entries", trigEngine = "plain", wordTrig = true },
    fmta(
      [[
        \begin{<>}%{<>}
          <>
        \end{<>}
      ]],
      {
        c(1, {
          t("pmatrix"),
          t("bmatrix"),
        }),
        i(2, "c"),
        d(3, tab, { 2 }, {
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
        rep(1),
      }
    )
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
