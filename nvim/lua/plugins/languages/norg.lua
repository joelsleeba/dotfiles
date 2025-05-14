return {
  "nvim-neorg/neorg",
  dependencies = { "image.nvim" },
  lazy = true, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
  ft = { "norg" },
  -- version = "*", -- Pin Neorg to the latest stable release
  config = true,
  opts = {
    load = {
      ["core.autocommands"] = {},
      ["core.completion"] = {
        config = {
          engine = "nvim-cmp",
        },
      },
      ["core.concealer"] = {
        config = {
          icon_preset = "varied",
        },
      },
      ["core.defaults"] = {},
      ["core.dirman"] = {
        config = {
          workspaces = {
            notes = "~/workspace/NotesHome/neorg",
          },
        },
      },
      ["core.integrations.treesitter"] = {},
      ["core.integrations.image"] = {},
      ["core.integrations.nvim-cmp"] = {},
      ["core.journal"] = {
        config = {
          workspace = "notes",
        },
      },
      ["core.latex.renderer"] = {},
      ["core.neorgcmd"] = {},
      ["core.ui.calendar"] = {},
    },
  },
  keys = {
    { "<leader>njp", "<cmd>Neorg journal yesterday<cr>", desc = "Open yesterday's journal" },
    { "<leader>njn", "<cmd>Neorg journal tomorrow<cr>", desc = "Open tomorrow's journal" },
    { "<leader>njt", "<cmd>Neorg journal today<cr>", desc = "Open today's journal" },
  },
}
