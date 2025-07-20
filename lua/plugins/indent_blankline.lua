return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
        indent = {
            char = "│", -- or "┊" or whatever you want
        },
        scope = {
            enabled = false, -- 🚫 Disable the block underline on first line
        },
    },
}
