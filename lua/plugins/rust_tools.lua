return {
  "simrat39/rust-tools.nvim",
  config = function()
    require("rust-tools").setup({
      --   tools = {
      --     inlay_hints = {
      --       auto = false,           -- Prevent rust-tools from automatically showing inlay hints
      --     },
      --   },
      --   server = {
      --     settings = {
      --       ["rust-analyzer"] = {
      --         inlayHints = {
      --           enable = true,               -- Enable inlay hints from rust-analyzer
      --         },
      --       },
      --     },
      --   },
    })
  end,
}
