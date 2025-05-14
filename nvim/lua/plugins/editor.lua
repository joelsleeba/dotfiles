return {
  -- nvim-ufo for better foldings
  {
    "kevinhwang91/nvim-ufo",
    dependencies = {
      "kevinhwang91/promise-async",
      "nvim-treesitter/nvim-treesitter",
    },
    enabled = false, -- default vim options takes care of this now
    event = { "BufEnter", "BufLeave" },
    opts = {
      provider_selector = function(bufnr, filetype, buftype)
        return { "treesitter", "indent" }
      end,
    },
    -- config = function()
    --   require("ufo").setup({
    --     provider_selector = function(bufnr, filetype, buftype)
    --       return { "treesitter", "indent" }
    --     end,
    --   })
    -- vim.o.foldcolumn = "1" -- '0' is not bad
    -- vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
    -- vim.o.foldlevelstart = 99
    -- vim.o.foldenable = true
    -- end,
  },

  -- img-clip.nvim for embedding images to buffers
  {
    "HakonHarnes/img-clip.nvim",
    event = "VeryLazy",
    opts = {
      -- add options here
      -- or leave it empty to use the default settings
    },
    keys = {
      -- suggested keymap
      { "<leader>pI", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" },
    },
  },

  -- nvim-colorizer.lua for indicating color pixels of color codes
  {
    "NvChad/nvim-colorizer.lua",
    enabled = true,
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      user_default_options = {
        names = false,
        mode = "virtualtext",
        rgb_fn = true,
        RRGGBBAA = true,
        hsl_fn = true,
      },
      filetypes = {
        "*",
        conf = { css = true },
        css = { css = true, tailwind = true },
        scss = { css = true, tailwind = true },
      },
    },

    -- Options
    --
    -- filetypes = { "*" },
    -- user_default_options = {
    --   RGB = true, -- #RGB hex codes
    --   RRGGBB = true, -- #RRGGBB hex codes
    --   names = true, -- "Name" codes like Blue or blue
    --   RRGGBBAA = false, -- #RRGGBBAA hex codes
    --   AARRGGBB = false, -- 0xAARRGGBB hex codes
    --   rgb_fn = false, -- CSS rgb() and rgba() functions
    --   hsl_fn = false, -- CSS hsl() and hsla() functions
    --   css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
    --   css_fn = false, -- Enable all CSS *functions*: rgb_fn, hsl_fn
    --   -- Available modes for `mode`: foreground, background,  virtualtext
    --   mode = "background", -- Set the display mode.
    --   -- Available methods are false / true / "normal" / "lsp" / "both"
    --   -- True is same as normal
    --   tailwind = false, -- Enable tailwind colors
    --   -- parsers can contain values used in |user_default_options|
    --   sass = { enable = false, parsers = { "css" }, }, -- Enable sass colors
    --   virtualtext = "■",
    --   -- update color values even if buffer is not focused
    --   -- example use: cmp_menu, cmp_docs
    --   always_update = false
    -- },
    -- -- all the sub-options of filetypes apply to buftypes
    -- buftypes = {},
  },
}
