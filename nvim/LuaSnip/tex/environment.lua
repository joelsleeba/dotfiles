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

-- depreciated, often will not work. Use the ls function
local rec_ls = function()
  return sn(nil, {
    c(1, {
      -- important!! Having the sn(...) as the first choice will cause infinite recursion.
      t({ "" }),
      -- The same dynamicNode as in the snippet (also note: self reference).
      sn(nil, { t({ "", "\t\\item " }), i(1), d(2, rec_ls, {}) }),
    }),
  })
end

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

-- function for the dynamicNode which deals with the number of items in lists
local lists = function(args, snip)
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
    -- table.insert(nodes, r(ins_indx, tostring(j) .. "x1", i(1)))
    -- ins_indx = ins_indx + 1
    for k = 2, 2 do
      table.insert(nodes, t("\\item "))
      table.insert(nodes, r(ins_indx, tostring(j) .. "x" .. tostring(k), i(1)))
      table.insert(nodes, t({ "", "\t" }))
      ins_indx = ins_indx + 1
    end
  end

  -- fix last node.
  nodes[#nodes] = t("")
  return sn(nil, nodes)
end

return {

  -- Define dm snippet for display math
  s(
    { trig = "([%c%s])dm", wordTrig = false, regTrig = true, priority = -29 },
    fmta(
      [[
      <>\[
          <>
        \]
      ]],
      {
        f(function(_, snip)
          return snip.captures[1]
        end),
        d(1, get_visual),
      }
    )
  ),

  -- Define im snippet for inline math
  s(
    { trig = "([^%a])im", wordTrig = false, regTrig = true, priority = -29 },
    fmta("<>$<>$", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      i(1),
    })
  ),

  -- Define qq snippet for quad spacing
  s(
    { trig = "([^%a])qq", regTrig = true },
    f(function(args, snip)
      return snip.captures[1] .. "\\quad "
    end, {})
  ),

  -- Define article snippet for latex templates
  s({ trig = "article", desc = "latex template" }, {
    c(1, {
      sn(
        nil,
        fmta(
          [[
\documentclass[11pt]{article}
\usepackage{geometry}
\usepackage{graphicx}
\usepackage{enumitem}
\usepackage[usenames,dvipsnames]{xcolor}
\usepackage[backend=biber, style=alphabetic]{biblatex}
\usepackage{url,hyperref}

\usepackage{amsmath} % math symbols, matrices, cases, trig functions, var-greek symbols.
\usepackage{amsfonts} % mathbb, mathfrak, large sum and product symbols.
\usepackage{amssymb} % extended list of math symbols from AMS. https://ctan.math.washington.edu/tex-archive/fonts/amsfonts/doc/amssymb.pdf
\usepackage{amsthm} % theorem styling.
\usepackage{mathrsfs} % mathscr fonts.
\usepackage{yhmath} % widehat.
\usepackage{empheq} % emphasize equations, extending 'amsmath' and 'mathtools'.
\usepackage{bm} % simplified bold math. Do \bm{math-equations-here}

\geometry{
  a4paper, % 'a4paper', 'c5paper', 'letterpaper', 'legalpaper'
  asymmetric, % don't swap margins in left and right pages. as opposed to 'twoside'
  centering, % to center the content between margins
  bindingoffset=0cm,
}

\hypersetup{
  colorlinks = true,
  linkcolor = {red!60!black},
  anchorcolor = red,
  citecolor = {green!50!black},
  urlcolor = magenta,
  }

\theoremstyle{plain} % default; italic text, extra space above and below
\newtheorem{theorem}{Theorem}[section]
\newtheorem{proposition}{Proposition}[section]
\newtheorem{lemma}{Lemma}[section]
\newtheorem{corollary}{Corollary}[theorem]

\theoremstyle{definition} % upright text, extra space above and below
\newtheorem{definition}{Definition}[section]
\newtheorem{example}{Example}[section]

\theoremstyle{remark} % upright text, no extra space above or below
\newtheorem{remark}{Remark}[section]
\newtheorem*{note}{Note} %'Notes' in italics and without counter 

\newcommand{\propositionautorefname}{Proposition}
\newcommand{\definitionautorefname}{Definition}
\newcommand{\lemmaautorefname}{Lemma}
\newcommand{\remarkautorefname}{Remark}
\newcommand{\exampleautorefname}{Example}

\addbibresource{<>.bib}


\begin{document}

\title{<>}

\author{
<> \\
<> \\
<> \\
\and
Author 2 \\
This University, Country \\
author@emaildomain.com \\
}

\maketitle

\begin{abstract}
<>
\end{abstract}



\printbibliography[heading=bibintoc]
\end{document}
          ]],
          {
            i(1, "articles"),
            i(2, "Document Title"),
            i(3, "Joel Sleeba"),
            i(4, "University of Houston"),
            i(5, "XXXXX@gmail.com"),
            i(6),
          }
        )
      ),
    }),

    c(2, {
      sn(
        nil,
        fmta(
          [[
            \documentclass{<>}<>
            \begin{document}
              <>
            \end{document}
          ]],
          { i(1, "article"), i(2), i(3) }
        )
      ),
    }),
  }),

  -- Define beg snippet for latex begin env
  s(
    { trig = "beg", desc = "begin environment" },
    fmta(
      [[
        \begin{<>}
          <>
        \end{<>}
      ]],
      { i(1, "environment"), i(2), rep(1) }
    )
  ),

  -- Define ls snippet for making dynamic lists
  -- Use <c-t> and <c-g> as defined in luasnip.lua change the no.of items
  s(
    { trig = "ls", desc = "lists" },
    fmta(
      [[
        \begin{<>}
          <>
        \end{<>}
      ]],
      {
        c(1, {
          t("itemize"),
          t("enumerate"),
        }),
        d(2, lists, { 1 }, {
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

  s(
    { trig = "tab", desc = "tables" },
    fmta(
      [[
      \begin{tabular}{<>}
        <>
      \end{tabular}
      ]],
      {
        i(1, "c"),
        d(2, tab, { 1 }, {
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
}
