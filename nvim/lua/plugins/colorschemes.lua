return {
    -- AstroNvim theme
    {
        "AstroNvim/astrotheme",
        enabled = true,
        priority = 1000,
        config = function()
            require("astrotheme").setup({
                palette = "astrodark",
                style = {
                    transparent = true, -- ✅ make background transparent
                    italic_comments = true,
                    borders = true,
                },
            })
            vim.cmd.colorscheme("astrodark")
        end,
    },

    {
        "ayu-theme/ayu-vim",
        enabled = true,
        priority = 1000,
        config = function()
            vim.cmd.colorscheme("ayu")
        end,
    },

    -- Catppuccin
    {
        "catppuccin/nvim",
        enabled = true,
        name = "catppuccin",
        priority = 1000,
        config = function()
            vim.cmd.colorscheme("catppuccin-mocha")
        end,
    },
}
