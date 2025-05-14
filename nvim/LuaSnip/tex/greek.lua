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

-- The triggers follow those of VimTeX-imaps with some additional letters for KaTeX
return {
  -- Define ga snippet expand to \alpha
  s(
    { trig = "(^|[^a-zA-Z])ga", desc = "α", trigEngine = "ecma", wordTrig = false },
    fmta("<>\\alpha", { f(function(_, snip)
      return snip.captures[1]
    end) }),
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

  -- Define gb snippet expand to \beta
  s(
    { trig = "(^|[^a-zA-Z])gb", desc = "β", trigEngine = "ecma", wordTrig = false },
    fmta("<>\\beta", { f(function(_, snip)
      return snip.captures[1]
    end) }),
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

  -- Define gg snippet expand to \gamma
  s(
    { trig = "(^|[^a-zA-Z])gg", desc = "γ", trigEngine = "ecma", wordTrig = false },
    fmta("<>\\gamma", { f(function(_, snip)
      return snip.captures[1]
    end) }),
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

  -- Define gd snippet expand to \delta
  s(
    { trig = "(^|[^a-zA-Z])gd", desc = "δ", trigEngine = "ecma", wordTrig = false },
    fmta("<>\\delta", { f(function(_, snip)
      return snip.captures[1]
    end) }),
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

  -- Define ge snippet expand to \epsilon
  s(
    { trig = "(^|[^a-zA-Z])ge", desc = "ε", trigEngine = "ecma", wordTrig = false },
    fmta("<>\\epsilon", { f(function(_, snip)
      return snip.captures[1]
    end) }),
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

  -- Define gz snippet expand to \zeta
  s(
    { trig = "(^|[^a-zA-Z])gz", desc = "ζ", trigEngine = "ecma", wordTrig = false },
    fmta("<>\\zeta", { f(function(_, snip)
      return snip.captures[1]
    end) }),
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

  -- Define gh snippet expand to \eta
  s(
    { trig = "(^|[^a-zA-Z])gh", desc = "η", trigEngine = "ecma", wordTrig = false },
    fmta("<>\\eta", { f(function(_, snip)
      return snip.captures[1]
    end) }),
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

  -- Define gq snippet expand to \theta
  s(
    { trig = "(^|[^a-zA-Z])gq", desc = "θ", trigEngine = "ecma", wordTrig = false },
    fmta("<>\\theta", { f(function(_, snip)
      return snip.captures[1]
    end) }),
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

  -- Define gi snippet expand to \iota
  s(
    { trig = "(^|[^a-zA-Z])gi", desc = "ι", trigEngine = "ecma", wordTrig = false },
    fmta("<>\\iota", { f(function(_, snip)
      return snip.captures[1]
    end) }),
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

  -- Define gk snippet expand to \kappa
  s(
    { trig = "(^|[^a-zA-Z])gk", desc = "κ", trigEngine = "ecma", wordTrig = false },
    fmta("<>\\kappa", { f(function(_, snip)
      return snip.captures[1]
    end) }),
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

  -- Define gl snippet expand to \lambda
  s(
    { trig = "(^|[^a-zA-Z])gl", desc = "λ", trigEngine = "ecma", wordTrig = false },
    fmta("<>\\lambda", { f(function(_, snip)
      return snip.captures[1]
    end) }),
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

  -- Define gm snippet expand to \mu
  s(
    { trig = "(^|[^a-zA-Z])gm", desc = "μ", trigEngine = "ecma", wordTrig = false },
    fmta("<>\\mu", { f(function(_, snip)
      return snip.captures[1]
    end) }),
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

  -- Define gn snippet expand to \nu
  s(
    { trig = "(^|[^a-zA-Z])gn", desc = "ν", trigEngine = "ecma", wordTrig = false },
    fmta("<>\\nu", { f(function(_, snip)
      return snip.captures[1]
    end) }),
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

  -- Define gx snippet expand to \xi
  s(
    { trig = "(^|[^a-zA-Z])gx", desc = "ξ", trigEngine = "ecma", wordTrig = false },
    fmta("<>\\xi", { f(function(_, snip)
      return snip.captures[1]
    end) }),
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

  -- Define go snippet expand to \omicron
  s(
    { trig = "(^|[^a-zA-Z])go", desc = "ο", trigEngine = "ecma", wordTrig = false },
    fmta("<>\\omicron", { f(function(_, snip)
      return snip.captures[1]
    end) }),
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

  -- Define gp snippet expand to \pi
  s(
    { trig = "(^|[^a-zA-Z])gp", desc = "π", trigEngine = "ecma", wordTrig = false },
    fmta("<>\\pi", { f(function(_, snip)
      return snip.captures[1]
    end) }),
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

  -- Define gr snippet expand to \rho
  s(
    { trig = "(^|[^a-zA-Z])gr", desc = "ρ", trigEngine = "ecma", wordTrig = false },
    fmta("<>\\rho", { f(function(_, snip)
      return snip.captures[1]
    end) }),
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

  -- Define gs snippet expands to \sigma
  s(
    { trig = "(^|[^a-zA-Z])gs", desc = "σ", trigEngine = "ecma", wordTrig = false },
    fmta("<>\\sigma", { f(function(_, snip)
      return snip.captures[1]
    end) }),
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

  -- Define gt snippet expands to \tau
  s(
    { trig = "(^|[^a-zA-Z])gt", desc = "τ", trigEngine = "ecma", wordTrig = false },
    fmta("<>\\tau", { f(function(_, snip)
      return snip.captures[1]
    end) }),
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

  -- Define gu snippet expands to \upsilon
  s(
    { trig = "(^|[^a-zA-Z])gu", desc = "υ", trigEngine = "ecma", wordTrig = false },
    fmta("<>\\upsilon", { f(function(_, snip)
      return snip.captures[1]
    end) }),
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

  -- Define gf snippet expands to \phi
  s(
    { trig = "(^|[^a-zA-Z])gf", desc = "φ", trigEngine = "ecma", wordTrig = false },
    fmta("<>\\phi", { f(function(_, snip)
      return snip.captures[1]
    end) }),
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

  -- Define gc snippet expands to \chi
  s(
    { trig = "(^|[^a-zA-Z])gc", desc = "χ", trigEngine = "ecma", wordTrig = false },
    fmta("<>\\chi", { f(function(_, snip)
      return snip.captures[1]
    end) }),
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

  -- Define gy snippet expands to \psi
  s(
    { trig = "(^|[^a-zA-Z])gy", desc = "ψ", trigEngine = "ecma", wordTrig = false },
    fmta("<>\\psi", { f(function(_, snip)
      return snip.captures[1]
    end) }),
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

  -- Define gw snippet expands to \omega
  s(
    { trig = "(^|[^a-zA-Z])gw", desc = "ω", trigEngine = "ecma", wordTrig = false },
    fmta("<>\\omega", { f(function(_, snip)
      return snip.captures[1]
    end) }),
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

  -- Define gA snippet expand to \Alpha
  s(
    { trig = "(^|[^a-zA-Z])gA", desc = "A", trigEngine = "ecma", wordTrig = false },
    fmta("<>\\Alpha", { f(function(_, snip)
      return snip.captures[1]
    end) }),
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

  -- Define gB snippet expand to \Beta
  s(
    { trig = "(^|[^a-zA-Z])gB", desc = "Β", trigEngine = "ecma", wordTrig = false },
    fmta("<>\\Beta", { f(function(_, snip)
      return snip.captures[1]
    end) }),
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

  -- Define gG snippet expand to \Gamma
  s(
    { trig = "(^|[^a-zA-Z])gG", desc = "Γ", trigEngine = "ecma", wordTrig = false },
    fmta("<>\\Gamma", { f(function(_, snip)
      return snip.captures[1]
    end) }),
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

  -- Define gD snippet expand to \Delta
  s(
    { trig = "(^|[^a-zA-Z])gD", desc = "Δ", trigEngine = "ecma", wordTrig = false },
    fmta("<>\\Delta", { f(function(_, snip)
      return snip.captures[1]
    end) }),
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

  -- Define gE snippet expand to \Epsilon
  s(
    { trig = "(^|[^a-zA-Z])gE", desc = "Ε", trigEngine = "ecma", wordTrig = false },
    fmta("<>\\Epsilon", { f(function(_, snip)
      return snip.captures[1]
    end) }),
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

  -- Define gZ snippet expand to \Zeta
  s(
    { trig = "(^|[^a-zA-Z])gZ", desc = "Ζ", trigEngine = "ecma", wordTrig = false },
    fmta("<>\\Zeta", { f(function(_, snip)
      return snip.captures[1]
    end) }),
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

  -- Define gH snippet expand to \Eta
  s(
    { trig = "(^|[^a-zA-Z])gH", desc = "Η", trigEngine = "ecma", wordTrig = false },
    fmta("<>\\Eta", { f(function(_, snip)
      return snip.captures[1]
    end) }),
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

  -- Define gQ snippet expand to \Theta
  s(
    { trig = "(^|[^a-zA-Z])gQ", desc = "Θ", trigEngine = "ecma", wordTrig = false },
    fmta("<>\\Theta", { f(function(_, snip)
      return snip.captures[1]
    end) }),
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

  -- Define gI snippet expand to \Iota
  s(
    { trig = "(^|[^a-zA-Z])gI", desc = "Ι", trigEngine = "ecma", wordTrig = false },
    fmta("<>\\Iota", { f(function(_, snip)
      return snip.captures[1]
    end) }),
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

  -- Define gK snippet expand to \Kappa
  s(
    { trig = "(^|[^a-zA-Z])gK", desc = "Κ", trigEngine = "ecma", wordTrig = false },
    fmta("<>\\Kappa", { f(function(_, snip)
      return snip.captures[1]
    end) }),
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

  -- Define gL snippet expand to \Lambda
  s(
    { trig = "(^|[^a-zA-Z])gL", desc = "Λ", trigEngine = "ecma", wordTrig = false },
    fmta("<>\\Lambda", { f(function(_, snip)
      return snip.captures[1]
    end) }),
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

  -- Define gM snippet expand to \Mu
  s(
    { trig = "(^|[^a-zA-Z])gM", desc = "Μ", trigEngine = "ecma", wordTrig = false },
    fmta("<>\\Mu", { f(function(_, snip)
      return snip.captures[1]
    end) }),
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

  -- Define gN snippet expand to \Nu
  s(
    { trig = "(^|[^a-zA-Z])gN", desc = "Ν", trigEngine = "ecma", wordTrig = false },
    fmta("<>\\Nu", { f(function(_, snip)
      return snip.captures[1]
    end) }),
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

  -- Define gX snippet expand to \Xi
  s(
    { trig = "(^|[^a-zA-Z])gX", desc = "Ξ", trigEngine = "ecma", wordTrig = false },
    fmta("<>\\Xi", { f(function(_, snip)
      return snip.captures[1]
    end) }),
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

  -- Define gO snippet expand to \Omricon
  s(
    { trig = "(^|[^a-zA-Z])gO", desc = "Ο", trigEngine = "ecma", wordTrig = false },
    fmta("<>\\Omicron", { f(function(_, snip)
      return snip.captures[1]
    end) }),
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

  -- Define gP snippet expand to \Pi
  s(
    { trig = "(^|[^a-zA-Z])gP", desc = "Π", trigEngine = "ecma", wordTrig = false },
    fmta("<>\\Pi", { f(function(_, snip)
      return snip.captures[1]
    end) }),
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

  -- Define gR snippet expand to \Rho
  s(
    { trig = "(^|[^a-zA-Z])gR", desc = "Ρ", trigEngine = "ecma", wordTrig = false },
    fmta("<>\\Rho", { f(function(_, snip)
      return snip.captures[1]
    end) }),
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

  -- Define gS snippet expand to \Sigma
  s(
    { trig = "(^|[^a-zA-Z])gS", desc = "Σ", trigEngine = "ecma", wordTrig = false },
    fmta("<>\\Sigma", { f(function(_, snip)
      return snip.captures[1]
    end) }),
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

  -- Define gT snippet expand to \Tau
  s(
    { trig = "(^|[^a-zA-Z])gT", desc = "Τ", trigEngine = "ecma", wordTrig = false },
    fmta("<>\\Tau", { f(function(_, snip)
      return snip.captures[1]
    end) }),
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

  -- Define gU snippet expand to \Upsilon
  s(
    { trig = "(^|[^a-zA-Z])gU", desc = "Υ", trigEngine = "ecma", wordTrig = false },
    fmta("<>\\Upsilon", { f(function(_, snip)
      return snip.captures[1]
    end) }),
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

  -- Define gF snippet expand to \Phi
  s(
    { trig = "(^|[^a-zA-Z])gF", desc = "Φ", trigEngine = "ecma", wordTrig = false },
    fmta("<>\\Phi", { f(function(_, snip)
      return snip.captures[1]
    end) }),
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

  -- Define gC snippet expand to \Chi
  s(
    { trig = "(^|[^a-zA-Z])gC", desc = "Χ", trigEngine = "ecma", wordTrig = false },
    fmta("<>\\Chi", { f(function(_, snip)
      return snip.captures[1]
    end) }),
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

  -- Define gY snippet expand to \Psi
  s(
    { trig = "(^|[^a-zA-Z])gY", desc = "Ψ", trigEngine = "ecma", wordTrig = false },
    fmta("<>\\Psi", { f(function(_, snip)
      return snip.captures[1]
    end) }),
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

  -- Define gW snippet expand to \Omega
  s(
    { trig = "(^|[^a-zA-Z])gW", desc = "Ω", trigEngine = "ecma", wordTrig = false },
    fmta("<>\\Omega", { f(function(_, snip)
      return snip.captures[1]
    end) }),
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

  -- Define gve snippet expand to \varepsilon
  s(
    { trig = "(^|[^a-zA-Z])gve", desc = "ε", trigEngine = "ecma", wordTrig = false },
    fmta("<>\\varepsilon", { f(function(_, snip)
      return snip.captures[1]
    end) }),
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

  -- Define gvq snippet expand to \vartheta
  s(
    { trig = "(^|[^a-zA-Z])gvq", desc = "ϑ", trigEngine = "ecma", wordTrig = false },
    fmta("<>\\vartheta", { f(function(_, snip)
      return snip.captures[1]
    end) }),
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

  -- Define gvk snippet expand to \varkappa
  s(
    { trig = "(^|[^a-zA-Z])gvk", desc = "ϰ", trigEngine = "ecma", wordTrig = false },
    fmta("<>\\varkappa", { f(function(_, snip)
      return snip.captures[1]
    end) }),
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

  -- Define gvp snippet expand to \varpi
  s(
    { trig = "(^|[^a-zA-Z])gvp", desc = "ϖ", trigEngine = "ecma", wordTrig = false },
    fmta("<>\\varpi", { f(function(_, snip)
      return snip.captures[1]
    end) }),
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

  -- Define gvr snippet expand to \varrho
  s(
    { trig = "(^|[^a-zA-Z])gvr", desc = "ϱ", trigEngine = "ecma", wordTrig = false },
    fmta("<>\\varrho", { f(function(_, snip)
      return snip.captures[1]
    end) }),
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

  -- Define gvs snippet expand to \varsigma
  s(
    { trig = "(^|[^a-zA-Z])gvs", desc = "ς", trigEngine = "ecma", wordTrig = false },
    fmta("<>\\varsigma", { f(function(_, snip)
      return snip.captures[1]
    end) }),
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

  -- Define gvf snippet expand to \varphi
  s(
    { trig = "(^|[^a-zA-Z])gvf", desc = "φ", trigEngine = "ecma", wordTrig = false },
    fmta("<>\\varphi", { f(function(_, snip)
      return snip.captures[1]
    end) }),
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

  -- Define gvD snippet expand to \varDelta
  s(
    { trig = "(^|[^a-zA-Z])gvD", desc = "Δ", trigEngine = "ecma", wordTrig = false },
    fmta("<>\\varDelta", { f(function(_, snip)
      return snip.captures[1]
    end) }),
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

  -- Define gvG snippet expand to \varGamma
  s(
    { trig = "(^|[^a-zA-Z])gvG", desc = "Γ", trigEngine = "ecma", wordTrig = false },
    fmta("<>\\varGamma", { f(function(_, snip)
      return snip.captures[1]
    end) }),
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

  -- Define gvQ snippet expand to \varTheta
  s(
    { trig = "(^|[^a-zA-Z])gvT", desc = "ϴ", trigEngine = "ecma", wordTrig = false },
    fmta("<>\\varTheta", { f(function(_, snip)
      return snip.captures[1]
    end) }),
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

  -- Define gvL snippet expand to \varLambda
  s(
    { trig = "(^|[^a-zA-Z])gvL", desc = "Λ", trigEngine = "ecma", wordTrig = false },
    fmta("<>\\varLambda", { f(function(_, snip)
      return snip.captures[1]
    end) }),
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

  -- Define gvX snippet expand to \varXi
  s(
    { trig = "(^|[^a-zA-Z])gvX", desc = "Ξ", trigEngine = "ecma", wordTrig = false },
    fmta("<>\\varXi", { f(function(_, snip)
      return snip.captures[1]
    end) }),
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

  -- Define gvP snippet expand to \varPi
  s(
    { trig = "(^|[^a-zA-Z])gvP", desc = "Π", trigEngine = "ecma", wordTrig = false },
    fmta("<>\\varPi", { f(function(_, snip)
      return snip.captures[1]
    end) }),
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

  -- Define gvS snippet expand to \varSigma
  s(
    { trig = "(^|[^a-zA-Z])gvS", desc = "Σ", trigEngine = "ecma", wordTrig = false },
    fmta("<>\\varSigma", { f(function(_, snip)
      return snip.captures[1]
    end) }),
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

  -- Define gvU snippet expand to \varUpsilon
  s(
    { trig = "(^|[^a-zA-Z])gvU", desc = "Υ", trigEngine = "ecma", wordTrig = false },
    fmta("<>\\varUpsilon", { f(function(_, snip)
      return snip.captures[1]
    end) }),
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

  -- Define gvF snippet expand to \varPhi
  s(
    { trig = "(^|[^a-zA-Z])gvF", desc = "Φ", trigEngine = "ecma", wordTrig = false },
    fmta("<>\\varPhi", { f(function(_, snip)
      return snip.captures[1]
    end) }),
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

  -- Define gvY snippet expand to \varPsi
  s(
    { trig = "(^|[^a-zA-Z])gvY", desc = "Ψ", trigEngine = "ecma", wordTrig = false },
    fmta("<>\\varPsi", { f(function(_, snip)
      return snip.captures[1]
    end) }),
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

  -- Define gvW snippet expand to \varOmega
  s(
    { trig = "(^|[^a-zA-Z])gvW", desc = "Ω", trigEngine = "ecma", wordTrig = false },
    fmta("<>\\varOmega", { f(function(_, snip)
      return snip.captures[1]
    end) }),
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
}
