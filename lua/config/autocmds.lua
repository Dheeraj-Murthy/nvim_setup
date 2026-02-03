-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

vim.api.nvim_create_autocmd("BufReadPre", {
    callback = function()
        if vim.fn.line("$") > 5000 then
            vim.cmd("TSBufDisable highlight")
        end
    end,
})
vim.cmd("colorscheme cyberdream")
vim.cmd("set laststatus=3")

-- mini sessions autosave debugging
-- Autocommand to print a message when session is written on exit
vim.api.nvim_create_autocmd('VimLeavePre', {
    callback = function()
        local msessions = require("mini.sessions")
        local ok = pcall(function()
            msessions.write('autosave') -- must match your `file` setting if set
        end)
        if ok then
            vim.schedule(function()
                print("💾 Auto-saved session to 'autosave'")
            end)
        end
    end,
})

vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "*",
    callback = function()
        vim.opt.statuscolumn = ""
    end,
})



vim.api.nvim_create_autocmd("BufWritePre", {
    callback = function()
        local clients = vim.lsp.get_clients({ bufnr = 0 })
        if #clients > 0 then
            vim.lsp.buf.format({ async = false })
        end
    end
})
