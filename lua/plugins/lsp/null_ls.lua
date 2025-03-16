return {
  "jose-elias-alvarez/null-ls.nvim",
  event = { "BufReadPre", "BufNewFile" },

  ft = { "python" },
  config = function()
    local null_ls = require("null-ls")

    -- Define your sources for Python and Markdown
    local python_sources = {
      null_ls.builtins.formatting.black,   -- Python formatter
      null_ls.builtins.formatting.isort,   -- Python import sorter
      null_ls.builtins.diagnostics.pylint, -- Python linter
    }
    local markdown_sources = {
      null_ls.builtins.formatting.prettier.with({
        filetypes = { "markdown" },
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

    null_ls.setup({
      sources = all_sources,
      on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
          -- Set up keymap for manual formatting
          vim.api.nvim_buf_set_keymap(
            bufnr,
            "n",
            "<leader>f",
            "<cmd>lua vim.lsp.buf.format({ async = true })<CR>",
            { noremap = true, silent = true }
          )

          -- Autoformat on save
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({ async = false })
              vim.opt_local.wrap = true
              vim.opt_local.linebreak = true -- break lines at word boundaries
              vim.opt_local.spell = true     -- optional: enable spell checking
            end,
          })
        end
      end,
    })
  end,
}
