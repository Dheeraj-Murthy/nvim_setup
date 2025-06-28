return {
    "nvim-lualine/lualine.nvim",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- Optional for icons

    config = function()
        require("lualine").setup({
            options = {
                icons_enabled = true,
                theme = "catppuccin",
                globalstatus = true,
                section_separators = { left = " ", right = " " },
                component_separators = { left = " ", right = " " },
            },
            sections = {
                lualine_a = { "mode" },                               -- Display mode in the first section
                lualine_b = { "branch", "diff", "diagnostics" },      -- Branch, git diff, diagnostics in the second section
                lualine_c = { "filename", "filetype" },               -- Show filename and filetype in the third section
                lualine_x = { "encoding", "fileformat", "filetype" }, -- File encoding, format, and type in the fourth section
                lualine_y = { "progress" },                           -- Show progress (e.g., percentage of file)
                lualine_z = { "location" },                           -- Display cursor position
            },
            inactive_sections = {
                lualine_a = { "filename" }, -- Show the filename only when inactive
                lualine_b = {},
                lualine_c = {},
                lualine_x = { "buffers" },
                lualine_y = {},
                lualine_z = {},
            },
            extensions = { "fugitive" }, -- Add extensions like 'fugitive' for git integration
        })
    end,
}
