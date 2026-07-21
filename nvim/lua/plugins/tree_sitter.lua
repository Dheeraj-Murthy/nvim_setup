return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    config = function()
        ---@diagnostic disable-next-line: missing-fields
        require("nvim-treesitter").setup({
            ensure_installed = { "cpp", "python", "javascript", "lua", "html", "css", "markdown", "markdown_inline" },
            sync_install = false,
            auto_install = false,
            ignore_install = {},

            highlight = {
                enable = true,
                disable = { "html" },
                additional_vim_regex_highlighting = false,
            },
            indent = {
                enable = false,
                disable = { "python" },
            },
            incremental_selection = {
                enable = false,
                keymaps = {
                    init_selection = "gnn",
                    node_incremental = "grn",
                    scope_incremental = "grc",
                    node_decremental = "grm",
                },
            },
        })
    end,
}
