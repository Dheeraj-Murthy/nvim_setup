return {
  "folke/snacks.nvim",
  --@module "snacks"
  priority = 1000,
  lazy = false,

  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    bigfile = { enabled = true },
    dashboard = {
      week_header = { enable = true, image = "~/Downloads/lights.jpeg" },
      enabled = true,
      sections = {
        { section = "header", indent = 60 },
        {
          { icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 2, gap = 0 },
          { section = "startup" },
        },
        {
          pane = 2,
          { section = "terminal", cmd = "", pane = 2, indent = 4, height = 9 },
          { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
          { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
        },
      },
    },
    indent = { enabled = false },
    input = { enabled = true },
    notifier = { enabled = true },
    explorer = { enabled = true },
    picker = {
      sources = {
        explorer = {
          -- your explorer picker configuration comes here
          -- or leave it empty to use the default settings
        }
      }
    },
    quickfile = { enabled = true },
    scroll = { enabled = false },
    statuscolumn = { enabled = false },
    words = { enabled = false },
    zen = {
      toggles = {
        dim = false,
      }
    }
  },
  keys = {
    {
      "<leader>gg",
      function()
        Snacks.lazygit()
      end,
      desc = "Lazygit",
    },
  },
}
