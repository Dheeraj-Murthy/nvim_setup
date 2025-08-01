return {
    "mason-org/mason.nvim",
    dependencies = {
        "mason-org/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
        -- import mason
        local mason = require("mason")

        -- import mason-lspconfig
        local mason_lspconfig = require("mason-lspconfig")

        local mason_tool_installer = require("mason-tool-installer")

        -- enable mason and configure icons
        mason.setup({
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
            },
        })
        -- require("mason-nvim-dap").setup {
        --   ensure_installed = { "codelldb" }
        -- }

        mason_lspconfig.setup({
            -- list of servers for mason to install
            ensure_installed = {
                "ts_ls",
                "html",
                "cssls",
                "tailwindcss",
                "lua_ls",
                "emmet_ls",
                "marksman",
                "rust_analyzer",
            },
            automatic_installation = true,
            automatic_enable = true,
        })

        mason_tool_installer.setup({
            ensure_installed = {
                "prettier", -- prettier formatter
                "eslint_d",
                "jupytext",
            },
        })
    end,
}
