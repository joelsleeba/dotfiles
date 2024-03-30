return {
  "ixru/nvim-markdown",
  enabled = true,
  dependencies = { "KeitaNakamura/tex-conceal.vim" },
  ft = "markdown",

  config = function()
    vim.g.vim_markdown_conceal = 2
    vim.b.tex_conceal = "abdmgs"
    -- vim.g.tex_conceal = ""
    vim.b.vim_markdown_math = 1
  end,
}
