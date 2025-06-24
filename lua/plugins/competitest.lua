return {
    "xeluxee/competitest.nvim",
    dependencies = "MunifTanjim/nui.nvim",
    -- lazy = false,
    ft = "cpp",
    config = function()
        require("competitest").setup({
            -- Custom configuration if needed
            save_current_file = true,            -- Save the current file before running
            testcases_directory = "./testcases", -- Custom directory for testcases
            maximum_time = 3000,                 -- Max execution time in milliseconds
            runner_ui = {
                interface = "split",             -- popup, split                              -- Use popup UI
            },
            compile_command = {
                cpp = {
                    exec = "clang++",                                            -- Compiler executable
                    args = { "-std=c++23", "-I/usr/local/include", "-Wall", "$(FNAME)", "-o", "a.out" }, -- Compiler arguments
                },
            },
            run_command = {
                cpp = {
                    exec = "./a.out",
                },
            },
            companion_port = 27121,                               -- Ensure this matches the extension's port
            received_problems_path = "$(CWD)/$(PROBLEM).$(FEXT)", -- Customize as needed
            open_received_problems = true,                        -- Open problem files automatically
        })

        --this is for competitest plugin
        vim.keymap.set("n", "<leader>ar", ":CompetiTest run<CR>", { desc = "Run Testcases" })
        vim.keymap.set("n", "<leader>aa", ":CompetiTest add_testcase<CR>", { desc = "Add Testcase" })
        vim.keymap.set("n", "<leader>ad", ":CompetiTest delete_testcase<CR>", { desc = "Delete Testcase" })
        vim.keymap.set("n", "<leader>ap", ":CompetiTest receive problem<CR>", { desc = "Receive Problem" })
        vim.keymap.set("n", "<leader>ae", ":CompetiTest edit_testcase<CR>", { desc = "Edit Testcase" })
        vim.keymap.set("n", "<leader>ac", ":CompetiTest receive contest<CR>", { desc = "Receive Contest" })
        vim.keymap.set("n", "<leader>a", "", { desc = "CompetiTest" })

        vim.api.nvim_create_autocmd("FileType", {
            pattern = "CompetiTest", -- If plugin sets specific filetype
            callback = function()
                vim.bo.modifiable = true
                vim.bo.readonly = false
            end
        })
    end,
}
