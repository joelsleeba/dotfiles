return {
  "jghauser/papis.nvim",
  dependencies = {
    "kkharji/sqlite.lua",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require("papis").setup({
      -- Your configuration goes here
      papis_python = {
        dir = "~/Books/Research/arveson/1969-subalgebras-of-c-algebras-a/",
        info_name = "info.yaml",
        notes_name = [[notes.md]],
      },
      enable_keymaps = true,
    })
  end,
}
