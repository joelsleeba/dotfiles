return {
  "KeitaNakamura/tex-conceal.vim",
  ft = { "markdown", "tex" },
  config = function()
    vim.g.tex_superscripts = "[0-9a-zA-W.,:;+-<>/()=]"
    vim.g.tex_subscripts = "[0-9aehijklmnoprstuvx,+-/().]"
    vim.g.tex_conceal_frac = 1
  end,
}
