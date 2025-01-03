-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
--
-- vim.api.nvim_create_autocmd("FileType", {
--     pattern = "cpp",
--     callback = function()
--         vim.api.nvim_buf_set_keymap(
--             0,
--             "n",
--             "<C-b>",
--             ":!g++-14 % -o a.out && ./a.out < input.txt > output.txt<CR>",
--             { noremap = true, silent = true }
--         )
--     end,
-- })
-- this is the auto cmd to set up cpp specific snippets
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "cpp",
--   callback = function()
--     vim.api.nvim_buf_set_keymap(0, "n", "bsic", rhs, opts)
--
-- })
--
-- lua/autocmds.lua
vim.api.nvim_create_autocmd("BufReadPre", {
    callback = function()
        if vim.fn.line("$") > 5000 then
            vim.cmd("TSBufDisable highlight")
        end
    end,
})
