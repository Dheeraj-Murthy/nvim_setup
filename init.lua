-- Disable LazyVim's default autocomplete suggestions
-- _G.Snacks = require("snacks.nvim")

vim.g.mapleader = " "
require("config.lazy")
require("config.lazy_opts")
require("config.lazy_maps")
require("config.keymaps")
require("config.options")
require("config.autocmds")
