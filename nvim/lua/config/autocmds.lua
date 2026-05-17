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

-- Change fold for latex files.
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = augroup("tex_folds"),
  pattern = { "tex", "latex" },
  callback = function()
    vim.opt.foldlevelstart = 0
    vim.opt.foldlevel = 3 -- To prevent autofold everytime I save
    vim.opt.foldminlines = 4 -- fold will be closed if the displayed no. of lines when unfolded exceeds this value

    function texExtractSectionContent(inputString)
      -- Define the patterns to match: \section{%a}, \subsection{%a}, and \subsubsection{%a}
      local sectionPattern = "\\section{(.+)}"
      local subsectionPattern = "\\subsection{(.+)}"
      local subsubsectionPattern = "\\subsubsection{(.+)}"
      local beginPattern = "\\begin{(.+)}"
      local beginNamePattern = "\\begin{([^}]+)}%[([^]]+)%]"

      -- Attempt to find matches in the input string
      local sectionMatch = inputString:match(sectionPattern)
      local subsectionMatch = inputString:match(subsectionPattern)
      local subsubsectionMatch = inputString:match(subsubsectionPattern)
      local beginMatch = inputString:match(beginPattern)
      local beginNameMatchType, beginNameMatchTag = inputString:match(beginNamePattern)

      if sectionMatch then
        return sectionMatch
      elseif subsectionMatch then
        return " * " .. subsectionMatch
      elseif subsubsectionMatch then
        return " ** " .. subsubsectionMatch
      elseif beginNameMatchType then
        return beginNameMatchType .. " (" .. beginNameMatchTag .. ")"
      elseif beginMatch then
        return beginMatch
      else
        return inputString
      end
    end

    -- Fold Method
    function _G.custom_foldtext()
      -- local commentstring = string.gsub(vim.bo.commentstring, "%%s", "")
      -- local prevline = vim.fn.getline(vim.v.foldstart - 1)
      local line = vim.fn.getline(vim.v.foldstart)
      local editorwidth = vim.fn.winwidth(0) - vim.fn.getwininfo(vim.fn.win_getid())[1].textoff
      local line_count = vim.v.foldend - vim.v.foldstart + 1

      -- local fillchars_fold = vim.opt.fillchars["fold"]
      local fillchars_fold = "-"

      line = texExtractSectionContent(line)

      return line
        .. " "
        .. string.rep(fillchars_fold, editorwidth - string.len(line) - string.len(line_count) - 14)
        .. " :: "
        .. line_count
        .. " lines"
    end
    vim.opt.foldtext = "v:lua.custom_foldtext()"
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

-- Update background on Focus change
vim.api.nvim_create_autocmd({ "FocusGained", "FocusLost" }, {
  group = augroup("background"),
  callback = function()
    local theme_file, _ = io.input("/tmp/color_scheme", "r")
    local theme = theme_file:read()
    theme_file:close()
    if theme == "day" then
      vim.opt.background = "light"
    else
      vim.opt.background = "dark"
    end
  end,
})
