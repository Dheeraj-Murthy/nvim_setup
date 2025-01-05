return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    -- "hrsh7th/cmp-nvim-lsp",
    "saghen/blink.cmp",
    { "antosha417/nvim-lsp-file-operations", config = true },
    {
      "folke/neodev.nvim",       -- Uncomment if using Lua development
    },
  },
  config = function()
    local lspconfig = require("lspconfig")
    local mason_lspconfig = require("mason-lspconfig")
    -- local cmp_nvim_lsp = require("cmp_nvim_lsp")

    -- Shared capabilities for autocompletion
    -- local capabilities = cmp_nvim_lsp.default_capabilities()
    local capabilities = require("blink.cmp").get_lsp_capabilities()

    -- Define diagnostic symbols only once
    local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
    for type, icon in pairs(signs) do
      vim.fn.sign_define("DiagnosticSign" .. type, { text = icon, texthl = "DiagnosticSign" .. type })
    end

    -- Shared `on_attach` function to reduce redundancy
    local function on_attach(client, bufnr)
      local keymap = vim.keymap.set
      local opts = { buffer = bufnr, silent = true }

      -- Set key mappings for LSP actions
      keymap("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)
      keymap("n", "gD", vim.lsp.buf.declaration, opts)
      keymap("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
      keymap("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)
      keymap("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)
      keymap({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
      keymap("n", "<leader>rn", vim.lsp.buf.rename, opts)
      keymap("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)
      keymap("n", "<leader>d", vim.diagnostic.open_float, opts)
      keymap("n", "[d", vim.diagnostic.goto_prev, opts)
      keymap("n", "]d", vim.diagnostic.goto_next, opts)
      keymap("n", "K", vim.lsp.buf.hover, opts)
      keymap("n", "<leader>rs", ":LspRestart<CR>", opts)

      -- Enable formatting if available
      if client.server_capabilities.documentFormattingProvider then
        vim.api.nvim_create_autocmd("BufWritePre", {
          buffer = bufnr,
          callback = function()
            vim.lsp.buf.format({ async = false })
          end,
        })
      end
    end
    -- Set up Mason LSP servers with streamlined configurations
    mason_lspconfig.setup_handlers({
      -- Default handler for all installed servers
      function(server_name)
        lspconfig[server_name].setup({
          capabilities = capabilities,
          on_attach = on_attach,
        })
      end,

      ["emmet_ls"] = function()
        lspconfig.emmet_ls.setup({
          capabilities = capabilities,
          filetypes = {
            "html",
            "typescriptreact",
            "javascriptreact",
            "css",
            "sass",
            "scss",
            "less",
          },
          on_attach = on_attach,
        })
      end,

      ["rust_analyzer"] = function()
        lspconfig.rust_analyzer.setup({
          capabilities = capabilities,
          settings = {
            ["rust-analyzer"] = {
              cargo = {
                allFeatures = true,                 -- Enable all Cargo features
              },
              checkOnSave = {
                command = "clippy",                 -- Use `clippy` for on-save checks
              },
              diagnostics = {
                enable = false,                 -- Enable diagnostics
              },
              assist = {
                importGranularity = "module",                 -- Suggest imports at the module level
                importPrefix = "by_self",                     -- Use `self` for imports
              },
              lens = {
                enable = true,                 -- Enable inlay lens
              },
              -- inlayHints = {
              --   enable = true,                         -- Enable inlay hints
              --   typeHints = true,                      -- Show type hints
              --   parameterHints = true,                 -- Show parameter hints
              -- },
            },
          },
        })
      end,

      ["lua_ls"] = function()
        lspconfig.lua_ls.setup({
          capabilities = capabilities,
          settings = {
            Lua = {
              diagnostics = { globals = { "vim" } },
              completion = { callSnippet = "Replace" },
            },
          },
          on_attach = on_attach,
        })
      end,

      ["clangd"] = function()
        lspconfig.clangd.setup({
          cmd = {
            "clangd",
            "--query-driver=/opt/homebrew/Cellar/gcc/14.2.0_1/bin/g++-14",             -- Use g++ instead of clang++
          },
          capabilities = capabilities,
          init_options = {
            clangdFileStatus = true,
            fallbackFlags = {
              -- "-xc++",
              -- "-std=c++17",
              -- "-I/opt/homebrew/Cellar/gcc/14.2.0_1/include/c++/14/",
              -- "-I/opt/homebrew/Cellar/gcc/14.2.0_1/include/c++/14/aarch64-apple-darwin24/",
              -- "-I /opt/homebrew/Cellar/gcc/14.2.0_1/bin/../lib/gcc/current/gcc/aarch64-apple-darwin24/14/../../../../../../include/c++/14",
              -- "-I /opt/homebrew/Cellar/gcc/14.2.0_1/bin/../lib/gcc/current/gcc/aarch64-apple-darwin24/14/../../../../../../include/c++/14/aarch64-apple-darwin24",
              -- "-I /opt/homebrew/Cellar/gcc/14.2.0_1/bin/../lib/gcc/current/gcc/aarch64-apple-darwin24/14/../../../../../../include/c++/14/backward",
              -- "-I /opt/homebrew/Cellar/gcc/14.2.0_1/bin/../lib/gcc/current/gcc/aarch64-apple-darwin24/14/include",
              -- "-I /opt/homebrew/Cellar/gcc/14.2.0_1/bin/../lib/gcc/current/gcc/aarch64-apple-darwin24/14/include-fixed",
              -- "-I /Library/Developer/CommandLineTools/SDKs/MacOSX15.sdk/usr/include",
              -- "-I /Library/Developer/CommandLineTools/SDKs/MacOSX15.sdk/System/Library/Frameworks",
              "-I/usr/local/include",
            },
          },
          on_attach = function(client, bufnr)
            on_attach(client, bufnr)
            print("Clangd attached to buffer " .. bufnr)
            client.server_capabilities.documentFormattingProvider = true
          end,
        })
      end,

      ["marksman"] = function()
        lspconfig.marksman.setup({
          capabilities = capabilities,
          filetypes = { "markdown" },
          on_attach = on_attach,
        })
      end,

      ["ts_ls"] = function()
        lspconfig.tsserver.setup({
          capabilities = capabilities,
          on_attach = function(client, bufnr)
            on_attach(client, bufnr)
            client.server_capabilities.documentFormattingProvider = true
            vim.api.nvim_create_autocmd("BufWritePre", {
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format({ async = false })
              end,
            })
            client.config.init_options = {
              hostInfo = "neovim",
              preferences = {
                importModuleSpecifierPreference = "relative",
              },
            }
          end,
        })
      end,
      ["pyright"] = function()
        lspconfig.pyright.setup({
          capabilities = capabilities,
          -- flags = lsp_flags,
          settings = {
            python = {
              analysis = {
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = "workspace",
              },
            },
          },
        })
      end,
    })
  end,
}
