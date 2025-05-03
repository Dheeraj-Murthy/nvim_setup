return {
    "scottmckendry/cyberdream.nvim",
    lazy = false,
    priority = 1000,
    opts = {
        transparent = true,
        highlights = {
            CursorLine = { bg = "NONE" }, -- make cursorline fully transparent
            LineNr = { fg = "#ffffff" },
            CursorLineNr = { fg = "#ff7700" },
            StatusLine = { bg = "NONE" },
        },
    }
}
