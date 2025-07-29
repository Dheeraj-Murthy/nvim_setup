return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "theHamsta/nvim-dap-virtual-text",
        "nvim-neotest/nvim-nio",
        "mason-org/mason.nvim",
        "jay-babu/mason-nvim-dap.nvim", -- Mason DAP integration
    },
    enabled = true,
    -- lazy = true,
    config = function()
        local dap = require "dap"
        local ui = require "dapui"

        require("dapui").setup()
        require("nvim-dap-virtual-text").setup()

        vim.fn.sign_define("DapStopped", { text = "➡", texthl = "Error", linehl = "", numhl = "DapStoppedLine" })
        vim.api.nvim_set_hl(0, "DapStoppedLine", { bg = "#ff00ff", bold = true }) -- Bright pink background

        -- 🔹 C++ Debug Adapter (codelldb)
        dap.adapters.lldb = {
            type = "executable",
            command = "codelldb", -- Use 'codelldb' if installed via Mason
            name = "lldb"
        }

        dap.configurations.cpp = {
            {
                name = "Launch C++",
                type = "lldb",
                request = "launch",
                program = function()
                    -- Automatically detect 'a.out' inside the current working directory
                    local exe = vim.fn.getcwd() .. "/a.out"
                    if vim.fn.filereadable(exe) == 1 then
                        return exe
                    else
                        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                    end
                end,
                cwd = "${workspaceFolder}",
                stopOnEntry = false,
                args = {},
            },
        }

        -- 🔹 C Configuration (same as C++)
        dap.configurations.c = dap.configurations.cpp

        vim.keymap.set("n", "<leader>d", "", { noremap = "true", desc = "Debugging" });
        -- 🔥 Keybindings
        vim.keymap.set("n", "<space>db", dap.toggle_breakpoint, { desc = "toggle breakpoint" })
        -- vim.keymap.set("n", "<space>dc", dap.run_to_cursor, { desc = "run to cursor" })

        -- Eval var under cursor
        vim.keymap.set("n", "<space>?", function()
            require("dapui").eval(nil, { enter = true })
        end, { desc = "eval var under cursor" })

        vim.keymap.set("n", "<F1>", dap.continue, { desc = "continue" })
        vim.keymap.set("n", "<F2>", dap.step_into, { desc = "step into" })
        vim.keymap.set("n", "<F3>", dap.step_over, { desc = "step over" })
        vim.keymap.set("n", "<F4>", dap.step_out, { desc = "step out" })
        vim.keymap.set("n", "<F5>", dap.step_back, { desc = "step back" })
        vim.keymap.set("n", "<leader>dR", dap.restart, { desc = "restart" })
        vim.keymap.set("n", "<leader>dc", "<Esc>:! clang++ -g -std=c++23 -Wall '%' -o a.out ");

        -- 🔹 Auto-open/close DAP UI
        dap.listeners.before.attach.dapui_config = function() ui.open() end
        dap.listeners.before.launch.dapui_config = function() ui.open() end
        dap.listeners.before.event_terminated.dapui_config = function() ui.close() end
        dap.listeners.before.event_exited.dapui_config = function() ui.close() end
    end,
}
