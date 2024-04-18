-- Autocmds are automatically loaded on the VeryLazy event
vim.opt.foldlevelstart = 1
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

-- Change the hyprlang config filetypes
vim.filetype.add({
  pattern = { [".*/hypr/.*%.conf"] = "hyprlang" },
})

-- Change foldmethod for latex files
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = augroup("latex_fold"),
  pattern = { "tex" },
  callback = function()
    vim.opt_local.foldmethod = "syntax"
    vim.opt_local.foldtext = "getline(v:foldstart)"
    vim.opt_local.foldlevelstart = 2
    vim.opt_local.foldnestmax = 4
  end,
})
--
-- -- Change foldmethod for latex files
-- vim.api.nvim_create_autocmd({ "FileType" }, {
--   group = augroup("lua_fold"),
--   pattern = { "lua" },
--   callback = function()
--     vim.opt_local.foldtext = ""
--   end,
-- })
