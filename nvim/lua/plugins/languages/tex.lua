return {
  -- tex-conceal.nvim for better conceal in tex files
  {
    "joelsleeba/tex-conceal.vim",
    ft = { "markdown", "tex", "norg" },
    -- enabled = false,
    config = function()
      vim.g.tex_superscripts = "[0-9a-zA-W.,:;+-<>/()=]"
      vim.g.tex_subscripts = "[0-9aehijklmnoprstuvx,+-/().]"
      vim.g.tex_conceal_frac = 1
      vim.g.tex_conceal_beg = 1
    end,
  },

  -- rnoweb-nvim for conceal
  {
    "joelsleeba/rnoweb-nvim",
    ft = { "tex", "markdown", "rnoweb", "norg", "latex" },
    -- commit = "87704c3807e1a8da530915b3d3289041e9b7df11",
    -- commit = "6863efaa40a18059af463537d093d9a2135a146e",
    -- commit = "0cf5029e61786759ee8a978a5d97ab1ff7d468a2",
    enabled = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = true,
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
        textopdf = "latexmk -pdf -halt-on-error -synctex=1 %docroot%",
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

  -- vimtex
  {
    "lervag/vimtex",
    lazy = false, -- we don't want to lazy load VimTeX
    enabled = false,
    -- tag = "v2.15", -- uncomment to pin to a specific release
    config = function()
      vim.g.vimtex_compiler_method = "latexmk"
      vim.g.vimtex_compiler_latexmk = {
        callback = 1,
        continuous = 1,
        executable = "latexmk",
        options = {
          "-pdf",
          "-shell-escape",
          "-verbose",
          "-file-line-error",
          "-synctex=1",
          "-interaction=nonstopmode",
        },
      }
      vim.g.vimtex_view_method = "sioyek"
      vim.g.vimtex_quickfix_ignore_filters = {
        "Command terminated with space",
        "LaTeX Font Warning: Font shape",
        "Package caption Warning: The option",
        [[Underfull \\hbox (badness [0-9]*) in]],
        "Package enumitem Warning: Negative labelwidth",
        [[Overfull \\hbox ([0-9]*.[0-9]*pt too wide)]],
        [[Package caption Warning: Unused \\captionsetup]],
        "Package typearea Warning: Bad type area settings!",
        [[Package fancyhdr Warning: \\headheight is too small]],
        [[Underfull \\hbox (badness [0-9]*) in paragraph at lines]],
        "Package hyperref Warning: Token not allowed in a PDF string",
        [[Overfull \\hbox ([0-9]*.[0-9]*pt too wide) in paragraph at lines]],
      }

      vim.g.vimtex_impags_enabled = false
    end,
  },

  -- papis.nvim for linking with bibliography manager papis
  {
    "jghauser/papis.nvim",
    dependencies = {
      "kkharji/sqlite.lua",
      "MunifTanjim/nui.nvim",
      "pysan3/pathlib.nvim",
      "nvim-neotest/nvim-nio",
    },
    ft = { "tex", "markdown", "norg" },
    config = function()
      require("papis").setup({
        -- Your configuration goes here
        init_filetypes = { "tex", "latex", "markdown", "norg", "yaml" },
        cite_formats = {
          tex = { "\\autocite{%s}", "\\autocite[tp]?%*?{%s}" },
          -- rnoweb-nvim might change ft to latex from tex
          latex = { "\\autocite{%s}", "\\autocite[tp]?%*?{%s}" },
          markdown = "@%s",
          rmd = "@%s",
          plain = "%s",
          org = { "[cite:@%s]", "%[cite:@%s]" },
          norg = "{= %s}",
        },
        enable_keymaps = true,

        ["cursor-actions"] = {
          -- The format of the popup shown on `:PapisShowPopup` (equivalent to points 1-3
          -- of `preview_format`)
          popup_format = {
            { "title", "%s", "PapisPopupTitle" },
            { "author", "%s", "PapisPopupAuthor" },
            { "year", "%s", "PapisPopupYear" },
          },
        },
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
