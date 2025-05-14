return {
  "kaarmu/typst.vim",
  ft = "typst",
  lazy = true,
  config = function()
    vim.g.typst_pdf_viewer = "sioyek"
  end,

  keys = {
    { "\\ll", "<cmd>TypstWatch<cr>", desc = "TypstWatch" },
  },
}
