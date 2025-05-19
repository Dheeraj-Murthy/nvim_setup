return {
    {
        "echasnovski/mini.nvim",
        version = "*",
        config = function()
            require("mini.surround").setup() -- Minimal setup for mini.surround
            require('mini.pairs').setup()
            require('mini.ai').setup()
            require('mini.snippets').setup()
        end,
    },
}
