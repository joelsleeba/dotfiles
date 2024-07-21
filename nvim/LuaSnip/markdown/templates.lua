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

return {

  -- Define letter snippet for writing letters
  s(
    { trig = "letter", desc = "letter property snippet for letters" },
    fmta(
      [[
        ---
        date: <>
        time: <>
        author: Joel
        ---

      ]],
      {
        f(function(_, snip)
          return os.date("%d-%m-%Y", os.time())
        end),
        f(function(_, snip)
          return os.date("%H:%M", os.time())
        end),
      }
    )
  ),

  -- Define post snippet for hugo posts
  s(
    { trig = "blog-post", desc = "hugo post template" },
    fmta(
      [[
        ---
        title: <>
        date: <>
        draft: true
        
        # weight: 1
        # aliases: ["/first"]
        tags: ["<>"]
        author: "Joel Sleeba"
        # author: ["Me", "You"] # multiple authors
        showToc: false
        TocOpen: false
        hidemeta: false
        comments: false
        description: ""
        canonicalURL: "https://joelsleeba.github.io/blog/"
        disableHLJS: true # to disable highlightjs
        disableShare: false
        disableHLJS: false
        hideSummary: false
        searchHidden: true
        ShowReadingTime: false
        ShowBreadCrumbs: false
        ShowPostNavLinks: true
        ShowWordCount: false
        ShowRssButtonInSectionTermList: true
        UseHugoToc: true
        
        math: true
        tikzjax: false
        
        cover:
            image: "" # image path/url
            alt: "" # alt text
            caption: "" # display caption under cover
            relative: false # when using page bundles set this to true
            hidden: true # only hide on current single page
        editPost:
            URL: "https://github.com/joelsleeba/joelsleeba.github.io/content"
            Text: "Suggest Changes" # edit text
            appendFilePath: true # to append file path to Edit link
        ---
      ]],
      {
        i(1, "post title"),
        f(function(_, snip)
          return os.date("%Y-%m-%dT%H:%M:%S", os.time())
        end),
        i(2, ""),
      }
    )
  ),
}
