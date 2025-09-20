-- ~/.config/nvim/lua/plugins/conform.lua
return {
    "stevearc/conform.nvim",
    opts = {
        formatters_by_ft = {
            markdown = { "prettier" }, -- You can also use "markdownlint" or both
        },
    },
}
