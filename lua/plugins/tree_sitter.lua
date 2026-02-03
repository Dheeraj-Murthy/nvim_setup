return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  dependencies = {
    "nvim-treesitter/playground",
  },
  config = function()
    ---@diagnostic disable-next-line: missing-fields
    require("nvim-treesitter.configs").setup({
      ensure_installed = { "cpp", "python", "javascript", "lua", "html", "css", "markdown", "markdown_inline" },
      sync_install = false, -- Async installation for better UI responsiveness
      auto_install = false, -- Avoid unnecessary installs during buffer entry
      ignore_install = {},

      highlight = {
        enable = true,
        disable = { "html" }, -- Disable for specific languages
        additional_vim_regex_highlighting = false,
      },
      indent = {
        enable = true,
        disable = { "python" }, -- Disable indentation where needed
      },
      incremental_selection = {
        enable = false,
        keymaps = {
          init_selection = "gnn",
          node_incremental = "grn",
          scope_incremental = "grc",
          node_decremental = "grm",
        },
      },
      playground = {
        enable = true,
        updatetime = 100, -- Less frequent updates
        persist_queries = false,
      },
    })
  end,
}
