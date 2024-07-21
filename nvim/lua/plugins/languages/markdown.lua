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
    enabled = true,
    ft = { "markdown" },
    dependencies = { "godlygeek/tabular" },
  },

  -- obsidian.nvim
  {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    enabled = false,
    event = {
      "BufReadPre " .. vim.fn.expand("~") .. "/workspace/NotesHome/Personal/**.md",
      "BufNewFile " .. vim.fn.expand("~") .. "/workspace/NotesHome/Personal/**.md",
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
      "nvim-telescope/telescope.nvim",
      -- "nvim-treesitter/nvim-treesitter",
      "ixru/nvim-markdown",
    },
    opts = {
      workspaces = {
        {
          name = "Personal",
          path = "~/workspace/NotesHome/Personal",
        },
      },

      open_app_foreground = false,
    },
  },
}
