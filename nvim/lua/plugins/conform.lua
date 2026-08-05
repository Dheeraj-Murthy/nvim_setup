-- ~/.config/nvim/lua/plugins/conform.lua
return {
    "stevearc/conform.nvim",
    opts = {
        formatters_by_ft = {
            markdown = { "prettier" },
        },

        -- optional: configure prettier to wrap lines
        formatters = {
            prettier = {
                prepend_args = { "--prose-wrap", "always", "--print-width", "80" },
            },
        },
    },
}
