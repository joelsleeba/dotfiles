return {
  -- nvim-markdown
  {
    "ixru/nvim-markdown",
    enabled = false,
    dependencies = { "KeitaNakamura/tex-conceal.vim" },
    ft = "markdown",
    config = function()
      vim.g.vim_markdown_conceal = 2
      vim.b.tex_conceal = "abdmgs"
      -- vim.g.tex_conceal = ""
      vim.b.vim_markdown_math = 1
    end,
  },

  -- vim-markdown
  {
    "preservim/vim-markdown",
    branch = "master",
    enabled = false,
    ft = { "markdown" },
    dependencies = { "godlygeek/tabular" },
  },

  -- best in class, render-markdown.nvim
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.icons" },
    enabled = false,
    ft = { "markdown" },
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
  },

  -- markview.nvim
  {
    "OXY2DEV/markview.nvim",
    lazy = false,
    opts = {
      preview = {
        filetypes = { "markdown", "md", "rmd", "quarto" },
        modes = { "i", "n", "no", "c" },
        hybrid_modes = { "i" },

        -- linewise_hybrid_mode = true,
      },
    },

    -- For blink.cmp's completion
    -- source
    -- dependencies = {
    --     "saghen/blink.cmp"
    -- },
  },

  -- obsidian.nvim
  {
    "obsidian-nvim/obsidian.nvim",
    -- version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    event = {
      "BufReadPre " .. vim.fn.expand("~") .. "/NotesHome/Personal/**.md",
      "BufNewFile " .. vim.fn.expand("~") .. "/NotesHome/Personal/**.md",
      "BufReadPre " .. vim.fn.expand("~") .. "/NotesHome/Zettlekasten/**.md",
      "BufNewFile " .. vim.fn.expand("~") .. "/NotesHome/Zettlekasten/**.md",
    },

    keys = {
      {
        "<leader>odd",
        "<cmd>Obsidian today<CR>",
        mode = { "i", "n" },
        desc = "Daily Notes Today",
      },
      {
        "<leader>ody",
        "<cmd>Obsidian today -1<CR>",
        mode = { "i", "n" },
        desc = "Daily Notes Yesterday",
      },
      {
        "<leader>odt",
        "<cmd>Obsidian today +1<CR>",
        mode = { "i", "n" },
        desc = "Daily Notes Tomorrow",
      },
    },

    opts = {
      workspaces = {
        {
          name = "Zettlekasten",
          path = "~/NotesHome/Zettlekasten/",
        },
      },

      notes_subdir = "ideas",

      completion = {
        -- blink = true,
      },

      footer = {
        enabled = true,
        format = "{{properties}} 󰓹  {{words}} 󱌯",
        -- format = "{{backlinks}}   {{properties}} 󰓹  {{words}} 󱌯",
        hl_group = "@property",
      },

      templates = {
        folder = "templates",
        date_format = "%Y/%m/%d",
        time_format = "%H:%M",
      },

      daily_notes = {
        enabled = true,
        folder = "DailyNotes",
        template = "DailyNotes.md",
        date_format = "YYYY/MM/DD",
        default_tags = { "journal", "daily" },
        workday_only = false,
      },

      image = {
        resolve = function(path, src)
          local api = require("obsidian.api")
          if api.path_is_note(path) then
            return api.resolve_attachment_path(src)
          end
        end,
      },
    },
  },
}
