-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--

vim.g.tex_fold_enabled = 1
vim.g.tex_flavor = "latex"
vim.g.tex_conceal = "abdmgs"
vim.opt.conceallevel = 2
vim.opt.wrap = true

-- Load LuaSnip snippets from file
-- require("luasnip.loaders.from_lua").lazy_load({ paths = "~/.config/nvim/LuaSnip/" })

-- Toggle theme dark/light
-- Define a global variable to store the current background color
-- vim.opt.background = "dark"
-- vim.g.background_color = "dark"
-- vim.g.colorscheme = "gruvbox"

-- Define a function to toggle the background color
-- function ToggleBackground()
--   if vim.g.background_color == "dark" then
--     vim.opt.background = "light"
--     vim.g.background_color = "light"
--   else
--     vim.opt.background = "dark"
--     vim.g.background_color = "dark"
--   end
-- end

-- Spell check for cmp-spell
vim.opt.spell = true
vim.opt.spelllang = { "en_us" }

-- Fold Method
vim.opt.foldmethod = "indent"
-- vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
