return {
  "jose-elias-alvarez/null-ls.nvim",
  event = { "BufReadPre", "BufNewFile" },
  servers = {
    pyright = {},
  },
  config = function()
    local null_ls = require("null-ls")

    -- Define your sources for Python only
    local python_sources = {
      null_ls.builtins.formatting.black,         -- Python formatter
      null_ls.builtins.formatting.isort,         -- Python import sorter
      null_ls.builtins.diagnostics.pylint,       -- Python linter
    }

    -- Set up null-ls for Python files only
    null_ls.setup({
      sources = python_sources,
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

          -- Autoformat on save for Python files only
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({ async = false })
            end,
          })
        end
      end,
    })

    -- Only attach the null-ls setup for Python files
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "python",
      callback = function()
        null_ls.setup({
          sources = python_sources,
        })
      end,
    })
  end,
}
