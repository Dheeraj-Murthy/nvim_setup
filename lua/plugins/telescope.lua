return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" }, -- Optional for fzf extension
    },
    config = function()
        require("telescope").setup({
            extensions = {
                fzf = {},
            },
            pickers = {
                find_files = {
                    -- theme = "ivy"
                }
            }
        })
        -- Load fzf extension if installed
        require("telescope").load_extension("fzf")
        vim.keymap.set("n", "<leader>fh", require('telescope.builtin').help_tags)
        vim.keymap.set("n", "<leader>fb", require('telescope.builtin').buffers, { desc = "Find Buffers" })
        vim.keymap.set("n", "<leader>fc", function()
            require('telescope.builtin').find_files {
                cwd = vim.fn.stdpath("config")
            }
        end)
    end,
}
