-- plugins/quarto.lua
return {
  {
    "quarto-dev/quarto-nvim",
    dependencies = {
      "jmbuhr/otter.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    ft = "quarto",
    config = function()
      require("quarto").setup({
        lspFeatures = {
          enabled = true,
          languages = { "python" },
          diagnostics = {
            enabled = true,
            triggers = { "BufWrite" },
          },
          completion = {
            enabled = true,
          },
        },
      })
    end,
  },
  { "jpalardy/vim-slime" },
  { "ekickx/clipboard-image.nvim" },
}
