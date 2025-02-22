return {
  {
    "echasnovski/mini.nvim",
    version = "*",
    config = function()
      require("mini.surround").setup() -- Minimal setup for mini.surround
      require('mini.pairs').setup()
      require('mini.snippets').setup()
      require('mini.sessions').setup({
        autoread = true,                            -- Load last session on startup
        autowrite = true,                           -- Save session before quitting
        directory = "~/.local/share/nvim/sessions", -- Where sessions are stored
      })
    end,
  },
}
