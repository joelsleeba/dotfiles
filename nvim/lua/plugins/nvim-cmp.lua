return {
  {
    "hrsh7th/nvim-cmp",
    version = false, -- last release is way too old
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "FelipeLema/cmp-async-path",
      -- "f3fora/cmp-spell",
      "hrsh7th/cmp-calc",
      "hrsh7th/cmp-emoji",
      "octaltree/cmp-look",
      "saadparwaiz1/cmp_luasnip",
      "kdheepak/cmp-latex-symbols",
    },
    opts = function()
      vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
      local cmp = require("cmp")
      local defaults = require("cmp.config.default")()
      return {
        completion = {
          completeopt = "menu,menuone,noinsert",
        },
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        window = {
          documentation = {
            border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },
            border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
            winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None",
          },
          completion = {
            border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },
            border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
            winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None",
            scrolloff = 0,
            col_offset = 0,
            side_padding = 1,
            scrollbar = false,
          },
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          ["<S-CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          ["<C-CR>"] = function(fallback)
            cmp.abort()
            fallback()
          end,
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "async_path" },
          { name = "calc" },
          { name = "emoji" },
          {
            name = "latex_symbols",
            option = {
              strategy = 0,
            },
          },
          {
            name = "buffer",
            option = {
              keyword_pattern = [[\k\+]],
            },
          },
          {
            name = "look",
            keyword_length = 3, -- I think I will be able to remember first few letters.
            option = {
              convert_case = true, -- convert the candidate to match input characters
              loud = true,
              -- dict = "/usr/share/dict/wordlists-english", -- list from kkrypt0nn/wordlists
              dict = "/usr/share/dict/MainEnglishDictionary_ProbWL.txt", -- list from berzerk0/Probable-Wordlists
              dflag = true,
              fflag = true, -- ignore case when matching
            },
          },
          -- }, { -- use these additional bracket wrapping to have sections come to completions separately.
          --   {
          --     name = "latex_symbols",
          --     option = {
          --       strategy = 0, -- mixed
          --     },
          --   },
          -- }, {
          --   {
          --     name = "buffer",
          --     option = {
          --       -- keyword_pattern = [[\k\+]],
          --     },
          --   },
          --   {
          --
          --     }
          -- }, {
          --   {
          --     name = "spell",
          --     option = {
          --       keep_all_entries = false,
          --       enable_in_context = function()
          --         return true
          --       end,
          --     },
          --   },
        }),
        formatting = {
          format = function(_, item)
            local icons = require("lazyvim.config").icons.kinds
            if icons[item.kind] then
              item.kind = icons[item.kind] .. item.kind
            end
            return item
          end,
        },
        experimental = {
          ghost_text = {
            hl_group = "CmpGhostText",
          },
        },
        sorting = defaults.sorting,
      }
    end,

    ---@param opts cmp.ConfigSchema
    config = function(_, opts)
      local cmp = require("cmp")
      for _, source in ipairs(opts.sources) do
        source.group_index = source.group_index or 1
      end
      cmp.setup(opts)

      -- -- `/` cmdline setup.
      -- cmp.setup.cmdline("/", {
      --   mapping = cmp.mapping.preset.cmdline(),
      --   sources = {
      --     { name = "buffer" },
      --   },
      -- })
      --
      -- -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      -- cmp.setup.cmdline(":", {
      --   mapping = cmp.mapping.preset.cmdline(),
      --   sources = cmp.config.sources({
      --     { name = "path" },
      --   }, {
      --     { name = "cmdline" },
      --   }),
      -- })
    end,
  },

  {
    "hrsh7th/cmp-cmdline",
    lazy = true,
    event = { "CmdlineEnter" },
    dependencies = {
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-buffer",
      "FelipeLema/cmp-async-path",
    },
    opts = {
      completion = {
        completeopt = "menu,menuone,noselect",
      },
      formatting = {
        fields = { "abbr", "menu" },
      },
      types = {
        {
          type = ":",
          sources = {
            { name = "async_path" },
            { name = "cmdline" },
          },
        },
        {
          type = { "/", "?" },
          sources = {
            { name = "buffer" },
          },
        },
      },
    },
    config = function(_, opts)
      local cmp = require("cmp")

      for _, opt in ipairs(opts.types) do
        cmp.setup.cmdline(
          opt.type,
          vim.tbl_extend("force", opts, {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources(opt.sources),
          })
        )
      end
    end,
  },
}
