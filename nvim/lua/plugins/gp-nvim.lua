return {
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
}
