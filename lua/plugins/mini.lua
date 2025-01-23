return {
  {
    "echasnovski/mini.nvim",
    version = "*",
    config = function()
      require("mini.surround").setup()       -- Minimal setup for mini.surround
    end,
  },
}
