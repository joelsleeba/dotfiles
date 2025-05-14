return {
  "frabjous/knap",
  opt = true,
  enabled = true,
  ft = { "tex", "md", "html" },
  config = function()
    -- set shorter name for keymap function
    local kmap = vim.keymap.set

    -- F5 processes the document once, and refreshes the view
    kmap({ "n", "v", "i" }, "\\ll", function()
      require("knap").process_once()
    end)

    -- F6 closes the viewer application, and allows settings to be reset
    kmap({ "n", "v", "i" }, "\\lq", function()
      require("knap").close_viewer()
    end)

    -- F7 toggles the auto-processing on and off
    kmap({ "n", "v", "i" }, "\\lc", function()
      require("knap").toggle_autopreviewing()
    end)

    -- F8 invokes a SyncTeX forward search, or similar, where appropriate
    kmap({ "n", "v", "i" }, "\\lv", function()
      require("knap").forward_jump()
    end)

    local gknapsettings = {
      htmloutputext = "html",
      htmltohtml = "none",
      htmltohtmlviewerlaunch = "falkon %outputfile%",
      htmltohtmlviewerrefresh = "none",
      mdoutputext = "html",
      mdtohtml = "pandoc --standalone %docroot% -o %outputfile%",
      mdtohtmlviewerlaunch = "falkon %outputfile%",
      mdtohtmlviewerrefresh = "none",
      mdtopdf = "pandoc %docroot% -o %outputfile%",
      mdtopdfviewerlaunch = "sioyek %outputfile%",
      mdtopdfviewerrefresh = "none",
      markdownoutputext = "html",
      markdowntohtml = "pandoc --standalone %docroot% -o %outputfile%",
      markdowntohtmlviewerlaunch = "falkon %outputfile%",
      markdowntohtmlviewerrefresh = "none",
      markdowntopdf = "pandoc %docroot% -o %outputfile%",
      markdowntopdfviewerlaunch = "sioyek %outputfile%",
      markdowntopdfviewerrefresh = "none",
      texoutputext = "pdf",
      textopdf = "pdflatex -interaction=batchmode -halt-on-error -synctex=1 %docroot%",
      textopdfviewerlaunch = "sioyek --inverse-search 'nvim --headless -c \"lua require('\"'\"'knaphelper'\"'\"').relayjump('\"'\"'%servername%'\"'\"','\"'\"'%1'\"'\"',%2,%3)\"' --new-window %outputfile%",
      textopdfviewerrefresh = "none",
      textopdfforwardjump = "sioyek --inverse-search 'nvim --headless -c \"lua require('\"'\"'knaphelper'\"'\"').relayjump('\"'\"'%servername%'\"'\"','\"'\"'%1'\"'\"',%2,%3)\"' --reuse-window --forward-search-file %srcfile% --forward-search-line %line% %outputfile%",
      -- textopdfviewerlaunch = "zathura --synctex-editor-command 'nvim --headless -c \"lua require('\"'\"'knaphelper'\"'\"').relayjump('\"'\"'%servername%'\"'\"','\"'\"'%{input}'\"'\"',%{line},0)\"' %outputfile%",
      -- textopdfviewerrefresh = "none",
      -- textopdfforwardjump = "zathura --synctex-forward=%line%:%column%:%srcfile% %outputfile%",
      textopdfshorterror = 'A=%outputfile% ; LOGFILE="${A%.pdf}.log" ; rubber-info "$LOGFILE" 2>&1 | head -n 1',
      delay = 1000,
    }

    vim.g.knap_settings = gknapsettings

    _G.xelatexcheck = function()
      local isxelatex = false
      local fifteenlines = vim.api.nvim_buf_get_lines(0, 0, 15, false)
      for l, line in ipairs(fifteenlines) do
        if
          (line:lower():match("xelatex"))
          or (line:match("\\usepackage[^}]*mathspec"))
          or (line:match("\\usepackage[^}]*fontspec"))
          or (line:match("\\usepackage[^}]*unicode-math"))
        then
          isxelatex = true
          break
        end
      end
      if isxelatex then
        local knapsettings = vim.b.knap_settings or {}
        knapsettings["textopdf"] = "xelatex -interaction=batchmode -halt-on-error -synctex=1 %docroot%"
        vim.b.knap_settings = knapsettings
      end
    end
    vim.api.nvim_create_autocmd({ "BufRead" }, { pattern = { "*.tex" }, callback = xelatexcheck })
  end,
}
