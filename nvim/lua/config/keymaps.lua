local map = vim.keymap.set

-- =====================================================
-- General Keymaps
-- =====================================================

-- Insert a new line below (like Cmd+Enter behavior)
map("n", "696969", "<Esc>o", { noremap = true, silent = true })
map("n", "<D-CR>", "<Esc>o", { noremap = true, silent = true })

-- Delete entire line using Cmd+Delete
-- (iTerm sends hex 0x16 mapped to <C-u>)
map("n", "<C-u>", ":<C-u>normal! dd<CR>", { noremap = true, silent = true })

-- Save file (Cmd+S)
map({ "n", "i" }, "696970", "<Esc>:w<CR>", { noremap = true, silent = true, desc = "Save File" })
map({ "n", "i" }, "<D-s>", "<Esc>:w<CR>", { noremap = true, silent = true, desc = "Save File" })
map({ "n", "i" }, "<D-S>", "<Esc>:w<CR>", { noremap = true, silent = true, desc = "Save File" })

-- Select entire buffer (Cmd+A)
map({ "i", "n" }, "696971", "ggVG", { noremap = true, silent = true })
map({ "i", "n" }, "<D-a>", "ggVG", { noremap = true, silent = true })

-- Restore default <C-u> behavior (half-page up)
-- (workaround mapping via custom keycode)
map("n", "42069", "<C-u>", { noremap = true, silent = true, desc = "" })

map({ "n", "v" }, "<leader>cf", function()
    vim.cmd('echo "Formatting file..."')
    require("conform").format({ lsp_fallback = true, async = false })
    vim.cmd('echo "File formatted."')
end, { noremap = true, desc = "Format File" })

-- =====================================================
-- Clipboard / Editing Behavior
-- =====================================================

-- Paste without overwriting yank register (visual mode)
map("v", "p", '"_dp', { noremap = true, silent = true, desc = "Continual paste" })

-- Delete without affecting default register
map("n", "dd", '"_dd', { noremap = true, silent = true, desc = "Delete without yank" })
map("n", "x", '"_x', { noremap = true, silent = true, desc = "Delete char without yank" })
map("v", "x", '"_x', { noremap = true, silent = true, desc = "Delete selection without yank" })

-- =====================================================
-- Zen Mode
-- =====================================================

-- Custom Zen toggle
map("n", "<leader>uz", ":ZenMode<CR>", { noremap = true, silent = true, desc = "Zen Mode" })

-- =====================================================
-- File / System Utilities
-- =====================================================

-- Open current working directory in Finder (macOS)
map({ "n", "v" }, "<leader>fo", function()
    vim.cmd("silent !open .")
end, { desc = "Open folder in Finder" })

-- =====================================================
-- Plugin-specific Keymaps
-- =====================================================

-- Mini.sessions: autosave session before quitting
map("n", "<leader>qq", function()
    local msessions = require("mini.sessions")
    local ok = pcall(function()
        msessions.write("autosave")
    end)
    if ok then
        print("💾 Auto-saved session to 'autosave'")
    end
    vim.cmd("qa")
end, { desc = "Auto-save session and Quit All" })

-- =====================================================
-- Competitive Programming / C++ Runner
-- =====================================================

-- Compile and run current C++ file
-- Input:  input.txt
-- Output: output.txt (live tailed)
map(
    "n",
    "<leader>rr",
    ":w !g++-14 % -o %:r && ./%:r < ./input.txt > ./output.txt && tail -f ./output.txt<CR>",
    { noremap = true, silent = true }
)

-- =====================================================
-- File Explorer
-- =====================================================

-- Toggle Snacks explorer
map("n", "<leader>e", function()
    Snacks.explorer()
end, { desc = "Toggle Snacks Explorer" })

-- =====================================================
-- Telescope (Fuzzy Finder)
-- =====================================================

map("n", "<leader> ", "<cmd>Telescope find_files<cr>")
map("n", "<leader>/", "<cmd>Telescope live_grep<cr>")
map("n", "<leader>tb", "<cmd>Telescope buffers<cr>")
map("n", "<leader>:", "<cmd>Telescope command_history<cr>", { desc = "Command History" })
map("n", "<leader>tk", "<cmd>Telescope keymaps<cr>", { desc = "Keymaps" })
map("n", "<leader>tr", "<cmd>Telescope registers<cr>", { desc = "Registers" })
map("n", "<leader>tj", "<cmd>Telescope jumplist<cr>", { desc = "Jump List" })
map("n", "<leader>tm", "<cmd>Telescope marks<cr>", { desc = "Marks" })
map("n", "<leader>td", "<cmd>Telescope diagnostics<cr>", { desc = "Diagnostics" })
