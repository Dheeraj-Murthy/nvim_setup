return {
    "nvimtools/none-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    ft = { "python", "markdown", "sql" }, -- added sql here
    config = function()
        local null_ls = require("null-ls")

        -- Define your sources for Python, Markdown, and SQL
        local python_sources = {
            null_ls.builtins.formatting.black,
            null_ls.builtins.formatting.isort,
            null_ls.builtins.diagnostics.pylint,
        }
        local markdown_sources = {
            null_ls.builtins.formatting.prettier.with({
                filetypes = { "markdown" },
            }),
        }
        local sql_sources = {
            null_ls.builtins.formatting.sqlfluff.with({
                extra_args = { "--dialect", "mysql" }, -- or postgres, depending on what you use
            }),
        }

        -- Combine sources into one flat list
        local all_sources = {}
        for _, source in ipairs(python_sources) do
            table.insert(all_sources, source)
        end
        for _, source in ipairs(markdown_sources) do
            table.insert(all_sources, source)
        end
        for _, source in ipairs(sql_sources) do
            table.insert(all_sources, source)
        end

        null_ls.setup({
            sources = all_sources,
            on_attach = function(client, bufnr)
                if client.supports_method("textDocument/formatting") then
                    vim.api.nvim_buf_set_keymap(
                        bufnr,
                        "n",
                        "<leader>f",
                        "<cmd>lua vim.lsp.buf.format({ async = true })<CR>",
                        { noremap = true, silent = true }
                    )

                    vim.api.nvim_create_autocmd("BufWritePre", {
                        buffer = bufnr,
                        callback = function()
                            vim.lsp.buf.format({ async = false })
                            vim.opt_local.wrap = true
                            vim.opt_local.linebreak = true
                            vim.opt_local.spell = true
                        end,
                    })
                end
            end,
        })
    end,
}
