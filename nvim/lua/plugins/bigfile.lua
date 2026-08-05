return {
    "LunarVim/bigfile.nvim",
    config = function()
        require("bigfile").setup({
            filesize = 2, -- size in MB
            pattern = { "*" }, -- file patterns
            features = {
                "indent_blankline",
                "illuminate",
                "lsp",
                "treesitter",
                "syntax",
                "matchparen",
                "vimopts",
                "filetype",
            },
        })
    end,
}
