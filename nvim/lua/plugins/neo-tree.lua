return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    sources = { "filesystem", "buffers", "git_status", "document_symbols" },
    open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "Outline" },
    filesystem = {
      bind_to_cwd = false,
      follow_current_file = { enabled = true },
      hijack_netrw_behavior = "disabled", -- default is "open_default", let "oil.nvim" do it
      use_libuv_file_watcher = true,
    },
    window = {
      mappings = {
        ["<space>"] = "none",
        ["h"] = "close_node",
        ["l"] = "open",
        ["L"] = "focus_preview",
        ["C"] = "set_root",
        ["."] = "toggle_hidden",
      },
    },
    default_component_configs = {
      indent = {
        with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
        expander_collapsed = "",
        expander_expanded = "",
        expander_highlight = "NeoTreeExpander",
      },
    },
  },
}
