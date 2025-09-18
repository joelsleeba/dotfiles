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
    dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.icons" },
    ft = { "markdown" },
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
  },

  -- obsidian.nvim
  {
    "obsidian-nvim/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    -- enabled = false,
    event = {
      "BufReadPre " .. vim.fn.expand("~") .. "/NotesHome/Personal/**.md",
      "BufNewFile " .. vim.fn.expand("~") .. "/NotesHome/Personal/**.md",
      "BufReadPre " .. vim.fn.expand("~") .. "/NotesHome/Zettlekasten/**.md",
      "BufNewFile " .. vim.fn.expand("~") .. "/NotesHome/Zettlekasten/**.md",
    },

    opts = {
      workspaces = {
        {
          name = "Zettlekasten",
          path = "~/NotesHome/Zettlekasten/",
        },
      },

      notes_subdir = "zettle",

      completion = {
        blink = true,
      },

      -- Drop this in favor of footer
      statusline = {
        enabled = true,
        format = "{{backlinks}}   {{properties}} 󰓹  {{words}} 󱌯",
      },
    },
  },
}
