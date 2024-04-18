return {
  -- tex-conceal.nvim for better conceal in tex files
  {
    "KeitaNakamura/tex-conceal.vim",
    ft = { "markdown", "tex" },
    config = function()
      vim.g.tex_superscripts = "[0-9a-zA-W.,:;+-<>/()=]"
      vim.g.tex_subscripts = "[0-9aehijklmnoprstuvx,+-/().]"
      vim.g.tex_conceal_frac = 1
    end,
  },

  -- knap.nvim for compiling tex files with keybindings
  {
    "frabjous/knap",
    opt = true,
    enabled = true,
    ft = { "tex", "md", "html" },
    config = function()
      -- set shorter name for keymap function
      local kmap = vim.keymap.set

      -- F5 processes the document once, and refreshes the view
      kmap({ "n", "v" }, "\\ll", function()
        require("knap").process_once()
      end)

      -- F6 closes the viewer application, and allows settings to be reset
      kmap({ "n", "v" }, "\\lq", function()
        require("knap").close_viewer()
      end)

      -- F7 toggles the auto-processing on and off
      kmap({ "n", "v" }, "\\lc", function()
        require("knap").toggle_autopreviewing()
      end)

      -- F8 invokes a SyncTeX forward search, or similar, where appropriate
      kmap({ "n", "v" }, "\\lv", function()
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
  },

  -- papis.nvim for linking with bibliography manager papis
  {
    "jghauser/papis.nvim",
    dependencies = {
      "kkharji/sqlite.lua",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("papis").setup({
        -- Your configuration goes here
        papis_python = {
          dir = "~/Books/Research",
          info_name = "info.yaml",
          notes_name = [[notes.md]],
        },
        enable_keymaps = true,
      })
    end,
  },

  -- toggleterm.nvim for toggling terminals
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    keys = {
      {
        "<leader>tc",
        function()
          require("toggleterm").send_lines_to_terminal("visual_lines", true, { args = 3 }) -- make this true to false  if python REPL fucks up
        end,
        desc = "Send selected lines to terminal",
        mode = { "s", "v", "n" },
      },
      {
        "<leader>td",
        "<cmd>ToggleTerm size=10 direction=horizontal<cr>",
        desc = "Open a bottom terminal at PWD",
      },
      {
        "<leader>tr",
        "<cmd>ToggleTerm direction=vertical<cr>",
        desc = "Open a right terminal at PWD",
      },
      {
        "<leader>tp",
        "<cmd>3TermExec cmd='ipython' direction='vertical'<cr>",
        desc = "toggle an ipython REPL",
      },
      {
        "<leader>tj",
        "<cmd>3TermExec cmd='julia' direction='vertical'<cr>",
        desc = "toggle a julia REPL",
      },
      {
        "<leader>tl",
        "<cmd>3TermExec cmd='lua' direction='vertical'<cr>",
        desc = "toggle a lua REPL",
      },
      {
        "<leader>ts",
        function()
          local Terminal = require("toggleterm.terminal").Terminal
          local ipython = Terminal:new({ cmd = "ipython", count = 3, direction = "vertical" })
          ipython:toggle()

          require("toggleterm").send_lines_to_terminal("visual_lines", true, { args = 3 })
        end,
        mode = { "v", "s", "n" },
        desc = "toggle an ipython REPL",
      },
    },
    opts = {
      shade_terminals = true,
      persist_size = false,
      direction = "horizontal",
      size = function(term)
        if term.direction == "horizontal" then
          return 15
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.4
        end
      end,
    },
    config = true,
  },
}
