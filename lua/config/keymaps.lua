-- Keymaps are automatically loaded on the VeryLazy event

-- this is the command for command enter. escape into a new line from withing a line
vim.keymap.set("n", "696969", "<Esc>o", { noremap = true, silent = true })
-- this is the keymap for command del. I have already set up del to return hex code 0x15 in iterm2 setting so that corrensponds to ctrl u this command just deletes the entire line
vim.keymap.set("n", "<C-u>", ":<C-u>normal! dd<CR>", { noremap = true, silent = true })
-- this is the key map to set command-s to save the current file
vim.keymap.set({ "n", "i" }, "696970", ":w<CR>", { noremap = true, silent = true })
-- this is the select all on pressing cmd-a keymap
vim.keymap.set({ "i", "n" }, "696971", "ggVG", { noremap = true, silent = true })
-- this is the keymap to remove the delete functionality of ctrl - u and make it go half page up
vim.keymap.set("n", "42069", "<C-u>", { noremap = true, silent = true, desc = "" })
-- this is the command to set nvim to paste only from the yank buffer
vim.api.nvim_set_keymap("v", "p", '"_dp', { noremap = true, silent = true, desc = "continnual paste" })

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
