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
}
