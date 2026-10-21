return {
  -- ai.nvim for Gemini
  {
    "gera2ld/ai.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    enabled = false,
    opts = {
      api_key = "", -- or read from env: `os.getenv('GEMINI_API_KEY')`
      -- The locale for the content to be defined/translated into
      locale = "en",
      -- The locale for the content in the locale above to be translated into
      alternate_locale = "zh",
    },
    cmd = { "GeminiDefine", "GeminiDefineV", "GeminiTranslate", "GeminiAsk" },
  },

  -- copilot.nvim for copilot
  {
    "github/copilot.vim",
    enabled = false,
    lazy = true,
  },

  -- codecompanion.nvim
  {
    "olimorris/codecompanion.nvim",
    version = "^19.0.0",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      interactions = {
        chat = {
          -- You can specify an adapter by name and model (both ACP and HTTP)
          adapter = {
            name = "copilot",
            model = "gpt-4.1",
          },
        },
        -- Or, just specify the adapter by name
        inline = {
          adapter = "anthropic",
        },
        cmd = {
          adapter = "openai",
        },
        background = {
          adapter = {
            name = "ollama",
            model = "qwen-7b-instruct",
          },
        },
      },
    },
  },

  -- gp.nvim for GPT
  {
    "robitx/gp.nvim",
    enabled = false,
    event = { "InsertEnter" },
    opts = {
      openai_api_key = { "rbw", "get", "openAI_API_KEY" },
    },
    -- config = function()
    -- require("gp").setup()
    -- or setup with your own config (see Install > Configuration in Readme)
    -- require("gp").setup(config)

    -- shortcuts might be setup here (see Usage > Shortcuts in Readme)
    -- end,
  },

  -- {
  --   "folke/sidekick.nvim",
  --   enabled = "false",
  --   opts = {
  --     -- add any options here
  --     cli = {
  --       -- mux = {
  --       --   backend = "zellij",
  --       --   enabled = true,
  --       -- },
  --     },
  --     nes = {
  --       enabled = false,
  --     },
  --   },
  --   keys = {
  --     {
  --       "<tab>",
  --       function()
  --         -- if there is a next edit, jump to it, otherwise apply it if any
  --         if not require("sidekick").nes_jump_or_apply() then
  --           return "<Tab>" -- fallback to normal tab
  --         end
  --       end,
  --       expr = true,
  --       desc = "Goto/Apply Next Edit Suggestion",
  --     },
  --     {
  --       "<c-.>",
  --       function()
  --         require("sidekick.cli").focus()
  --       end,
  --       desc = "Sidekick Focus",
  --       mode = { "n", "t", "i", "x" },
  --     },
  --     {
  --       "<leader>aa",
  --       function()
  --         require("sidekick.cli").toggle()
  --       end,
  --       desc = "Sidekick Toggle CLI",
  --     },
  --     {
  --       "<leader>as",
  --       function()
  --         require("sidekick.cli").select()
  --       end,
  --       -- Or to select only installed tools:
  --       -- require("sidekick.cli").select({ filter = { installed = true } })
  --       desc = "Select CLI",
  --     },
  --     {
  --       "<leader>ad",
  --       function()
  --         require("sidekick.cli").close()
  --       end,
  --       desc = "Detach a CLI Session",
  --     },
  --     {
  --       "<leader>at",
  --       function()
  --         require("sidekick.cli").send({ msg = "{this}" })
  --       end,
  --       mode = { "x", "n" },
  --       desc = "Send This",
  --     },
  --     {
  --       "<leader>af",
  --       function()
  --         require("sidekick.cli").send({ msg = "{file}" })
  --       end,
  --       desc = "Send File",
  --     },
  --     {
  --       "<leader>av",
  --       function()
  --         require("sidekick.cli").send({ msg = "{selection}" })
  --       end,
  --       mode = { "x" },
  --       desc = "Send Visual Selection",
  --     },
  --     {
  --       "<leader>ap",
  --       function()
  --         require("sidekick.cli").prompt()
  --       end,
  --       mode = { "n", "x" },
  --       desc = "Sidekick Select Prompt",
  --     },
  --     -- Example of a keybinding to open Claude directly
  --     {
  --       "<leader>ac",
  --       function()
  --         require("sidekick.cli").toggle({ name = "claude", focus = true })
  --       end,
  --       desc = "Sidekick Toggle Claude",
  --     },
  --   },
  -- },
}
