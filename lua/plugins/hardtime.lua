return {
    "m4xshen/hardtime.nvim",
    dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
    enabled = false,
    opts = {
        max_count = 3, -- Maximum times a key can be pressed
        enabled = true,
        restricted_keys = {
            ["h"] = { "n", "x" },       -- Limit presses of 'h'
            ["j"] = { "n", "x" },       -- Limit presses of 'j'
            ["k"] = { "n", "x" },       -- Limit presses of 'k'
            ["l"] = { "n", "x" },       -- Limit presses of 'l'
            ["<Up>"] = { "n", "x" },    -- Limit presses of Up arrow
            ["<Down>"] = { "n", "x" },  -- Limit presses of Down arrow
            ["<Left>"] = { "n", "x" },  -- Limit presses of Left arrow
            ["<right>"] = { "n", "x" }, -- limit presses of right arrow
        },
        hint = true,                    -- Show hints when key press limit is reached
        notification = true,            -- Show notification when the limit is exceeded
        disabled_keys = {               -- Disable keys that shouldn't be restricted
            -- ["<Esc>"] = { "n", "x" }, -- Allow using Escape without restriction
        },
    },
}
