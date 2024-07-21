return {
  -- oil.nvim for manipulating files from the buffer
  {
    "stevearc/oil.nvim",
    event = { "User" },
    opts = {},
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },

  -- vim-slime to copying files over to a repl. Can be replaced by toggleterm.nvim
  {
    "jpalardy/vim-slime",
    enabled = false,
    lazy = true,
    ft = { "python", "julia", "haskell", "sh" },
    event = { "InsertEnter" },
    keys = {
      { "<C-c><C-c>", "<cmd>SlimeSend<cr>", desc = "SlimeSend" },
    },

    config = function()
      vim.g.slime_target = "dtach"
    end,
  },

  -- toggleterm.nvim for toggling terminals
  {
    "akinsho/toggleterm.nvim",
    -- version = "*",
    keys = {
      {
        "<leader>tc",
        function()
          require("toggleterm").send_lines_to_terminal("visual_lines", true, { args = 3 }) -- make this true to false  if python REPL fucks up
        end,
        desc = "Send selected lines to terminal",
        mode = { "s", "v", "n" },
      },
      {
        "<leader>td",
        "<cmd>ToggleTerm size=10 direction=horizontal<cr>",
        desc = "Open a bottom terminal at PWD",
      },
      {
        "<leader>tr",
        "<cmd>ToggleTerm direction=vertical<cr>",
        desc = "Open a right terminal at PWD",
      },
      {
        "<leader>tp",
        "<cmd>3TermExec cmd=\"ipython --no-autoindent\" direction='vertical'<cr>",
        desc = "toggle an ipython REPL",
      },
      {
        "<leader>tj",
        "<cmd>3TermExec cmd='julia' direction='vertical'<cr>",
        desc = "toggle a julia REPL",
      },
      {
        "<leader>tl",
        "<cmd>3TermExec cmd='lua' direction='vertical'<cr>",
        desc = "toggle a lua REPL",
      },
      {
        "<leader>ts",
        function()
          local Terminal = require("toggleterm.terminal").Terminal
          local ipython = Terminal:new({ cmd = "ipython", count = 3, direction = "vertical" })
          ipython:toggle()

          require("toggleterm").send_lines_to_terminal("visual_lines", true, { args = 3 })
        end,
        mode = { "v", "s", "n" },
        desc = "toggle an ipython REPL",
      },
    },
    opts = {
      shade_terminals = true,
      persist_size = false,
      direction = "horizontal",
      -- trim_spaces = false,
      size = function(term)
        if term.direction == "horizontal" then
          return 15
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.4
        end
      end,
    },
    config = true,
  },

  -- image.nvim for displaying images
  {
    "3rd/image.nvim",
    ft = { "markdown", "norg" },
    dependencies = { "leafo/magick" },
    opts = {
      backend = "kitty",
      -- integrations = {
      --   neorg = {
      --     enabled = true,
      --     clear_in_insert_mode =
      --   }
      -- }
    },
  },

  -- nwm for neovim window manager
  {
    "altermo/nwm",
    branch = "x11",
    enabled = false,
  },
}
