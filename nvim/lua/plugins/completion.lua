return {
  -- nvim-cmp for the completion engine
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
      "kdheepak/cmp-latex-symbols", -- Would rather use LuaSnips
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
          { name = "neorg" },
          { name = "papis" },
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

  -- cmp-cmdline for something. Lets see
  {
    "hrsh7th/cmp-cmdline",
    lazy = true,
    enabled = false,
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

  -- LuaSnip for snippets
  {
    "L3MON4D3/LuaSnip",
    build = (not jit.os:find("Windows"))
        and "echo 'NOTE: jsregexp is optional, so not a big deal if it fails to build'; make install_jsregexp"
      or nil,
    dependencies = {
      -- "rafamadriz/friendly-snippets",
      -- config = function()
      --   require("luasnip.loaders.from_vscode").lazy_load()
      -- end,
    },

    opts = {},

    keys = {
      {
        "<tab>",
        function()
          return require("luasnip").expand_or_jumpable() and "<Plug>luasnip-expand-or-jump" or "<tab>"
          -- return require("luasnip").expand_or_jumpable() and require("luasnip").expand_or_jump() or "<tab>"
        end,
        expr = true,
        silent = true,
        mode = "i",
        desc = "expand",
      },
      {
        "<tab>",
        function()
          require("luasnip").jump(1)
        end,
        mode = "s",
        desc = "jump +1",
      },
      {
        "<s-tab>",
        function()
          require("luasnip").jump(-1)
        end,
        mode = { "i", "s" },
        desc = "jump -1",
      },
      {
        "<c-e>",
        function()
          if require("luasnip").choice_active() then
            require("luasnip").change_choice(1)
          end
        end,
        mode = { "i", "s" },
        desc = "next choice",
      },
      {
        "<c-g>",
        "<cmd>lua _G.dynamic_node_external_update(1)<Cr>",
        mode = { "i", "s" },
        desc = "add one row in a dynamic node",
      },
      {
        "<c-t>",
        "<cmd>lua _G.dynamic_node_external_update(2)<Cr>",
        mode = { "i", "s" },
        desc = "remove one row in a dynamic node",
      },
      {
        "<Leader>Sr",
        function()
          require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/LuaSnip" })
          vim.api.nvim_echo({ { "Successfully refreshed snippetts", "None" } }, false, {})
        end,
        desc = "Reload snippets",
        mode = { "s", "n" },
      },
    },

    config = function()
      require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/LuaSnip/" })

      local ls = require("luasnip")
      local util = require("luasnip.util.util")
      local node_util = require("luasnip.nodes.util")

      ls.config.set_config({
        history = true,
        delete_check_events = "TextChanged, TextChangedI",
        enable_autosnippets = true,
        update_events = "TextChanged, TextChangedI",
        store_selection_keys = "<tab>",
      })

      local function find_dynamic_node(node)
        -- the dynamicNode-key is set on snippets generated by a dynamicNode only (its'
        -- actual use is to refer to the dynamicNode that generated the snippet).
        while not node.dynamicNode do
          node = node.parent
        end
        return node.dynamicNode
      end

      local external_update_id = 0
      -- func_indx to update the dynamicNode with different functions.
      function dynamic_node_external_update(func_indx)
        -- most of this function is about restoring the cursor to the correct
        -- position+mode, the important part are the few lines from
        -- `dynamic_node.snip:store()`.

        -- find current node and the innermost dynamicNode it is inside.
        local current_node = ls.session.current_nodes[vim.api.nvim_get_current_buf()]
        local dynamic_node = find_dynamic_node(current_node)

        -- to identify current node in new snippet, if it is available.
        external_update_id = external_update_id + 1
        current_node.external_update_id = external_update_id

        -- store which mode we're in to restore later.
        local insert_pre_call = vim.fn.mode() == "i"
        -- is byte-indexed! Doesn't matter here, but important to be aware of.
        local cursor_pos_pre_relative = util.pos_sub(util.get_cursor_0ind(), current_node.mark:pos_begin_raw())

        -- leave current generated snippet.
        node_util.leave_nodes_between(dynamic_node.snip, current_node)

        -- call update-function.
        local func = dynamic_node.user_args[func_indx]
        if func then
          -- the same snippet passed to the dynamicNode-function. Any output from func
          -- should be stored in it under some unused key.
          func(dynamic_node.parent.snippet)
        end

        -- last_args is used to store the last args that were used to generate the
        -- snippet. If this function is called, these will most probably not have
        -- changed, so they are set to nil, which will force an update.
        dynamic_node.last_args = nil
        dynamic_node:update()

        -- everything below here isn't strictly necessary, but it's pretty nice to have.

        -- try to find the node we marked earlier.
        local target_node = dynamic_node:find_node(function(test_node)
          return test_node.external_update_id == external_update_id
        end)

        if target_node then
          -- the node that the cursor was in when changeChoice was called exists
          -- in the active choice! Enter it and all nodes between it and this choiceNode,
          -- then set the cursor.
          node_util.enter_nodes_between(dynamic_node, target_node)

          if insert_pre_call then
            util.set_cursor_0ind(util.pos_add(target_node.mark:pos_begin_raw(), cursor_pos_pre_relative))
          else
            node_util.select_node(target_node)
          end
          -- set the new current node correctly.
          ls.session.current_nodes[vim.api.nvim_get_current_buf()] = target_node
        else
          -- the marked node wasn't found, just jump into the new snippet noremally.
          ls.session.current_nodes[vim.api.nvim_get_current_buf()] = dynamic_node.snip:jump_into(1)
        end
      end
    end,
  },

  -- Disable mini.pairs. LuaSnippets take care of it
  {
    "echasnovski/mini.pairs",
    enabled = false,
  },
}
