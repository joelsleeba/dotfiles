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

  -- Define ba snippet for Banach algebra
  s(
    { trig = "ba", desc = "Banach algebra", trigEngine = "plain", wordTrig = true, snippetType = snippet },
    fmta(
      [[
        Banach algebra
      ]],
      {}
    )
  ),

  -- Define bs snippet for Banach space
  s(
    { trig = "bs", desc = "Banach space", trigEngine = "plain", wordTrig = true, snippetType = snippet },
    fmta(
      [[
         Banach space
       ]],
      {}
    )
  ),

  -- Define ca snippet for C* algebra
  s(
    { trig = "ca", desc = "C* algebra", trigEngine = "plain", wordTrig = true, snippetType = snippet },
    fmta(
      [[
        C* algebra
      ]],
      {}
    )
  ),

  -- Define dct snippet for dominated convergence theorem
  s(
    {
      trig = "dct",
      desc = "dominated convergence theorem",
      trigEngine = "plain",
      wordTrig = true,
      snippetType = snippet,
    },
    fmta(
      [[
        Lebesgue dominated convergence theorem
      ]],
      {}
    )
  ),

  -- Define diagzn snippet for diagonalization
  s(
    { trig = "diagzn", desc = "diagonalization", trigEngine = "plain", wordTrig = true, snippetType = snippet },
    fmta(
      [[
        diagonalization
      ]],
      {}
    )
  ),

  -- Define eval snippet for eigenvalue
  s(
    { trig = "eval", desc = "eigenvalue", trigEngine = "plain", wordTrig = true, snippetType = snippet },
    fmta(
      [[
        eigenvalue
      ]],
      {}
    )
  ),

  -- Define evec snippet for eigenvector
  s(
    { trig = "evec", desc = "eigenvector", trigEngine = "plain", wordTrig = true, snippetType = snippet },
    fmta(
      [[
        eigenvector
      ]],
      {}
    )
  ),

  -- Define fd snippet for finite dimensional
  s(
    { trig = "fd", desc = "finite dimensional", trigEngine = "plain", wordTrig = true, snippetType = snippet },
    fmta(
      [[
        finite dimensional
      ]],
      {}
    )
  ),

  -- Define func snippet for function
  s(
    { trig = "func", desc = "function", trigEngine = "plain", wordTrig = true, snippetType = snippet },
    fmta(
      [[
        function
      ]],
      {}
    )
  ),

  -- Define ftsoc snippet for for the sake of contradiction
  s(
    {
      trig = "ftsoc",
      desc = "for the sake of contradiction",
      trigEngine = "plain",
      wordTrig = true,
      snippetType = snippet,
    },
    fmta(
      [[
        For the sake of contradiction, assume that
      ]],
      {}
    )
  ),

  -- Define hbt snippet for Hahn-Banach theorem
  s(
    { trig = "hbt", desc = "Hahn-Banach theorem", trigEngine = "plain", wordTrig = true, snippetType = snippet },
    fmta(
      [[
        Hahn-Banach theorem
      ]],
      {}
    )
  ),

  -- Define hs snippet for Hilbert space
  s(
    { trig = "hs", desc = "Hilbert space", trigEngine = "plain", wordTrig = true, snippetType = snippet },
    fmta(
      [[
        Hilbert space
      ]],
      {}
    )
  ),

  -- Define iff snippet for if and only if
  s(
    { trig = "iff", desc = "if and only if", trigEngine = "plain", wordTrig = true, snippetType = snippet },
    fmta(
      [[
        if and only if
      ]],
      {}
    )
  ),

  -- Define ips snippet for inner product space
  s(
    { trig = "ips", desc = "inner product space", trigEngine = "plain", wordTrig = true, snippetType = snippet },
    fmta(
      [[
      inner product space
      ]],
      {}
    )
  ),

  -- Define isoiso snippet for isometrically isomorphic
  s(
    { trig = "isoiso", desc = "isometrically isomorphic", trigEngine = "plain", wordTrig = true, snippetType = snippet },
    fmta(
      [[
        isometrically isomorphic
      ]],
      {}
    )
  ),

  -- Define let snippet for Let ---- be ----
  s(
    { trig = "let", desc = "Let ---- be ----", trigEngine = "plain", wordTrig = true, snippetType = snippet },
    fmta(
      [[
        Let $<>$ be <>
      ]],
      { i(1, "X"), i(2, "something") }
    )
  ),

  -- Define lctvs snippet for locally compact topological vector space
  s(
    {
      trig = "lctvs",
      desc = "locally compact topological vector space",
      trigEngine = "plain",
      wordTrig = true,
      snippetType = snippet,
    },
    fmta(
      [[
        locally compact topological vector space
      ]],
      {}
    )
  ),

  -- Define lf snippet for linear functional
  s(
    { trig = "lf", desc = "linear functional", trigEngine = "plain", wordTrig = true, snippetType = snippet },
    fmta(
      [[
        linear functional
      ]],
      {}
    )
  ),

  -- Define nbd snippet for neighborhood
  s(
    { trig = "nbd", desc = "neighborhood", trigEngine = "plain", wordTrig = true, snippetType = snippet },
    fmta(
      [[
        neighborhood
      ]],
      {}
    )
  ),

  -- Define onb snippet for orthonormal basis
  s(
    { trig = "onb", desc = "orthonormal basis", trigEngine = "plain", wordTrig = true, snippetType = snippet },
    fmta(
      [[
        orthonormal basis
      ]],
      {}
    )
  ),

  -- Define ons snippet for orthonormal set
  s(
    { trig = "ons", desc = "orthonormal set", trigEngine = "plain", wordTrig = true, snippetType = snippet },
    fmta(
      [[
        orthonormal set
      ]],
      {}
    )
  ),

  -- Define pd snippet for positive definite
  s(
    { trig = "pd", desc = "positive definite", trigEngine = "plain", wordTrig = true, snippetType = snippet },
    fmta(
      [[
        positive definite
      ]],
      {}
    )
  ),

  -- Define psd snippet for positive semidefinite
  s(
    { trig = " psd", desc = "positive semidefinite", trigEngine = "plain", wordTrig = true, snippetType = snippet },
    fmta(
      [[
        positive semidefinite
      ]],
      {}
    )
  ),

  -- Define rnt snippet for Radon-Nikodym theorem
  s(
    { trig = "rnt", desc = "Radon-Nikodym theorem", trigEngine = "plain", wordTrig = true, snippetType = snippet },
    fmta(
      [[
        Radon-Nikodym theorem
      ]],
      {}
    )
  ),

  -- Define sigal snippet for Sigma Algebra
  s(
    { trig = "sigal", desc = "Sigma Algebra", trigEngine = "plain", wordTrig = true, snippetType = snippet },
    fmta(
      [[
        $\sigma$-algebra
      ]],
      {}
    )
  ),

  -- Define sa snippet for self-adjoint
  s(
    { trig = "sa", desc = "self-adjoint", trigEngine = "plain", wordTrig = true, snippetType = snippet },
    fmta(
      [[
        self-adjoint
      ]],
      {}
    )
  ),

  -- Define sq snippet for sequence
  s(
    { trig = "sq", desc = "sequence", trigEngine = "plain", wordTrig = true, snippetType = snippet },
    fmta(
      [[
        sequence
      ]],
      {}
    )
  ),

  -- Define st snippet for such that
  s(
    { trig = "st", desc = "such that", trigEngine = "plain", wordTrig = true, snippetType = snippet },
    fmta(
      [[
        such that
      ]],
      {}
    )
  ),

  -- Define tfae snippet for the following are equivalent
  s(
    {
      trig = "tfae",
      desc = "the following are equivalent",
      trigEngine = "plain",
      wordTrig = true,
      snippetType = snippet,
    },
    fmta(
      [[
        the following are equivalent
      ]],
      {}
    )
  ),

  -- Define vna snippet for von Neumann algebra
  s(
    { trig = "vna", desc = "von Neumann algebra", trigEngine = "plain", wordTrig = true, snippetType = snippet },
    fmta(
      [[
        von Neumann algebra
      ]],
      {}
    )
  ),

  -- Define vs snippet for vector space
  s(
    { trig = "vs", desc = "vector space", trigEngine = "plain", wordTrig = true, snippetType = snippet },
    fmta(
      [[
        vector space
      ]],
      {}
    )
  ),

  -- Define wlog snippet for without loss of generality
  s(
    { trig = "wlog", desc = "without loss of generality", trigEngine = "plain", wordTrig = true, snippetType = snippet },
    fmta(
      [[
        Without loss of generality, assume that
      ]],
      {}
    )
  ),
}
