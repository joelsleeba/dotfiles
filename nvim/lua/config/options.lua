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

function texExtractSectionContent(inputString)
  -- Define the patterns to match: \section{%a}, \subsection{%a}, and \subsubsection{%a}
  local sectionPattern = "\\section{(.+)}"
  local subsectionPattern = "\\subsection{(.+)}"
  local subsubsectionPattern = "\\subsubsection{(.+)}"
  local beginPattern = "\\begin{(.+)}"

  -- Attempt to find matches in the input string
  local sectionMatch = inputString:match(sectionPattern)
  local subsectionMatch = inputString:match(subsectionPattern)
  local subsubsectionMatch = inputString:match(subsubsectionPattern)
  local beginMatch = inputString:match(beginPattern)

  if sectionMatch then
    return sectionMatch
  elseif subsectionMatch then
    return " * " .. subsectionMatch
  elseif subsubsectionMatch then
    return " ** " .. subsubsectionMatch
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

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldcolumn = "0"
vim.opt.foldtext = "v:lua.custom_foldtext()"
vim.opt.foldlevel = 99 -- if low the folds close automatically on update
vim.opt.foldlevelstart = 1 -- foldlevel but only executed on buffer start
vim.opt.foldnestmax = 4
vim.opt.foldminlines = 4 -- fold will be closed if the displayed no. of lines when unfolded exceeds this value
vim.opt.fillchars = { eob = "-", fold = "-", foldopen = "", foldclose = "" }

-- Markdown with Telescope
vim.g.vim_markdown_frontmatter = 1
