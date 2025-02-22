return {
  {
    "folke/zen-mode.nvim",
    lazy = false,
    config = function()
      require("zen-mode").setup({
        plugins = {
          twilight = { enabled = false }, -- Disable Twilight inside Zen Mode
        }
      })
    end
  },
  {
    "folke/twilight.nvim",
    enabled = false, -- Completely disable Twilight
  }
}

