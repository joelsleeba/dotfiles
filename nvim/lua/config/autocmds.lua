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

-- Change foldmethod, autopairs for latex files.
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = augroup("latex"),
  pattern = { "tex", "latex" },
  callback = function()
    vim.opt.foldlevelstart = 0
    vim.opt.foldlevel = 1
    vim.opt.foldminlines = 4 -- fold will be closed if the displayed no. of lines when unfolded exceeds this value

    -- vim.cmd([[
    --   syn region texBoldStyle matchgroup=texTypeStyle start="\\begin\s*{" end="}" concealends contains=@texItalGroup
    --   syn region texBoldStyle matchgroup=texTypeStyle start="\\end\s*{\a*" end="}" concealends contains=@texItalGroup
    -- ]])
  end,
})

-- Change foldmethod for norg files. Let Treesitter take care of this too
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = augroup("norg_fold"),
  pattern = { "norg" },
  callback = function()
    vim.opt.foldlevelstart = 0
    vim.opt.foldlevel = 0
    vim.opt.foldminlines = 2 -- fold will be closed if the displayed no. of lines when unfolded exceeds this value
  end,
})
