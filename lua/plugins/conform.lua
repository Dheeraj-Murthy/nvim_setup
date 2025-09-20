-- ~/.config/nvim/lua/plugins/conform.lua
return {
    "stevearc/conform.nvim",
    opts = {
        formatters_by_ft = {
            markdown = { "prettier" },
        },

        -- ✅ Correct way to enable format on save
        format_on_save = {
            lsp_fallback = true, -- fallback to LSP if no formatter
            timeout_ms = 500,    -- optional: format timeout
        },

        -- optional: configure prettier to wrap lines
        formatters = {
            prettier = {
                prepend_args = { "--prose-wrap", "always", "--print-width", "80" },
            },
        },
    },
}
