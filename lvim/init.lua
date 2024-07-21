require("core/lazy") -- bootstrap lazy.nvim package manager
require("core/autocmd") -- copying some settings from brainfucksec/neovim.lua
require("core/keymaps") -- again copying from brainfucksec/neovim.lua

require("lazy").setup("plugins")
