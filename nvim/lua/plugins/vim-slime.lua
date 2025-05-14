return {
  "jpalardy/vim-slime",
  lazy = true,
  ft = { "python", "julia", "haskell", "sh" },
  event = { "InsertEnter" },
  keys = {
    { "<C-c><C-c>", "<cmd>SlimeSend<cr>", desc = "SlimeSend" },
  },

  config = function()
    vim.g.slime_target = "dtach"
  end,
}
