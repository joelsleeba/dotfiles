-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--

vim.g.tex_fold_enabled = 1
vim.g.tex_flavor = "latex"
vim.g.tex_conceal = "abdmgs"
vim.opt.conceallevel = 2
vim.opt.wrap = true

-- Spell check for cmp-spell
vim.opt.spell = true
vim.opt.spelllang = { "en_us" }

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldcolumn = "0"
vim.opt.foldlevel = 99 -- if low the folds close automatically on update
vim.opt.foldlevelstart = 1 -- foldlevel but only executed on buffer start
vim.opt.foldnestmax = 100
vim.opt.foldminlines = 4 -- fold will be closed if the displayed no. of lines when unfolded exceeds this value
vim.opt.fillchars = { eob = "-", fold = "-", foldopen = "", foldclose = "" }

-- Markdown with Telescope
vim.g.vim_markdown_frontmatter = 1
