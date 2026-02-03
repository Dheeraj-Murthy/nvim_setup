-- Keymaps are automatically loaded on the VeryLazy event

--^ General Keymaps
-- this is the command for command enter. escape into a new line from withing a line
vim.keymap.set("n", "696969", "<Esc>o", { noremap = true, silent = true })
vim.keymap.set("n", "<D-CR>", "<Esc>o", { noremap = true, silent = true })
-- this is the keymap for command del. I have already set up del to return hex code 0x16 in iterm2 setting so that corrensponds to ctrl u this command just deletes the entire line
vim.keymap.set("n", "<C-u>", ":<C-u>normal! dd<CR>", { noremap = true, silent = true })
-- vim.keymap.set("n", "<D-Del>", "<Esc>d0<CR>", { noremap = true, silent = true })
-- this is the key map to set command-s to save the current file
vim.keymap.set({ "n", "i" }, "696970", "<Esc>:w<CR>",
    { noremap = true, silent = true, desc = "Save File" })
vim.keymap.set({ "n", "i" }, "<D-s>", "<Esc>:w<CR>", { noremap = true, silent = true, desc = "Save File" })
vim.keymap.set({ "n", "i" }, "<D-S>", "<Esc>:w<CR>", { noremap = true, silent = true, desc = "Save File" })
-- this is the select all on pressing cmd-a keymap
vim.keymap.set({ "i", "n" }, "696971", "ggVG", { noremap = true, silent = true })
vim.keymap.set({ "i", "n" }, "<D-a>", "ggVG", { noremap = true, silent = true })
-- this is the keymap to remove the delete functionality of ctrl - u and make it go half page up
vim.keymap.set("n", "42069", "<C-u>", { noremap = true, silent = true, desc = "" })
-- this is the command to set nvim to paste only from the yank buffer
vim.api.nvim_set_keymap("v", "p", '"_dp', { noremap = true, silent = true, desc = "continnual paste" })
vim.api.nvim_set_keymap("n", "dd", '"_dd', { noremap = true, silent = true, desc = "delete does not go to clipboard" })
vim.api.nvim_set_keymap("n", "x", '"_x', { noremap = true, silent = true, desc = "delete does not go to clipboard" })
vim.api.nvim_set_keymap("v", "x", '"_x', { noremap = true, silent = true, desc = "delete does not go to clipboard" })


-- keymap to open current file in finder
vim.keymap.set({ "n", "v" }, "<leader>fo", function()
    vim.cmd("silent !open .")
end, { desc = "Open folder in Finder" })

--^ Plugin specific keymaps
-- mini sesssions autosave on quit
vim.keymap.set("n", "<leader>qq", function()
    local msessions = require("mini.sessions")
    local ok = pcall(function()
        msessions.write("autosave")
    end)
    if ok then
        print("💾 Auto-saved session to 'autosave'")
    end
    vim.cmd("qa")
end, { desc = "Auto-save session and Quit All" })

-- Define key mappings only for Quarto filetypes
vim.api.nvim_create_autocmd("FileType", {
    pattern = "quarto",
    callback = function()
        local opts = { buffer = true, noremap = true, silent = true }
        -- Render the document
        vim.keymap.set("n", "<leader>pr", ":w<CR>:QuartoPreview<CR>", opts)
        -- Close the preview
        vim.keymap.set("n", "<leader>pc", ":QuartoClosePreview<CR>", opts)
        -- Render a specific code cell (useful for quick testing)
        vim.keymap.set("n", "<leader>pq", ":QuartoSendAbove<CR>", opts)
        -- Render and preview the entire document
        vim.keymap.set("n", "<leader>pp", ":QuartoPreview<CR>", opts)
    end,
})

-- vim.keymap.set({ "v" }, "s", "s");

vim.api.nvim_set_keymap(
    "n",
    "<leader>rr",
    ":w !g++-14 % -o %:r && ./%:r < ./input.txt > ./output.txt && tail -f ./output.txt<CR>",
    { noremap = true, silent = true }
)


vim.keymap.set("n", "<leader>e", function() Snacks.explorer() end, { desc = "Toggle SnacksTree" })

-- Telescope keybindings
vim.keymap.set("n", "<leader> ", "<cmd>Telescope find_files<cr>")
vim.keymap.set("n", "<leader>/", "<cmd>Telescope live_grep<cr>")
vim.keymap.set("n", "<leader>bf", "<cmd>Telescope buffers<cr>")
vim.g.mapleader = " "
