return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },

    dependencies = {
        -- "hrsh7th/cmp-nvim-lsp", -- optional, your custom blink.cmp instead
        "saghen/blink.cmp",
        { "antosha417/nvim-lsp-file-operations", config = true },
        {
            "folke/neodev.nvim", -- Uncomment if using Lua development
        },
    },
    config = function()
        local lspconfig = require("lspconfig")
        local mason_lspconfig = require("mason-lspconfig")
        mason_lspconfig.setup()
        -- mason_lspconfig.setup_handlers({
        --     function(server)
        --         require("lspconfig")[server].setup({})
        --     end,
        -- })
        local capabilities = require("blink.cmp").get_lsp_capabilities()
        capabilities.textDocument.completion.completionItem.snippetSupport = true

        local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
        for type, icon in pairs(signs) do
            vim.fn.sign_define("DiagnosticSign" .. type, { text = icon, texthl = "DiagnosticSign" .. type })
        end

        local function on_attach(client, bufnr)
            local keymap = vim.keymap.set
            local opts = { buffer = bufnr, silent = true }

            keymap("n", "gd", vim.lsp.buf.definition, opts)
            keymap("n", "gD", vim.lsp.buf.declaration, opts)
            keymap("n", "gi", vim.lsp.buf.implementation, opts)
            keymap("n", "gt", vim.lsp.buf.type_definition, opts)
            keymap("n", "gr", "<cmd>Telescope lsp_references<CR>", opts)
            keymap("n", "<leader>rn", vim.lsp.buf.rename, opts)

            if client.server_capabilities.documentFormattingProvider then
                vim.api.nvim_create_autocmd("BufWritePre", {
                    buffer = bufnr,
                    callback = function()
                        vim.lsp.buf.format({ async = false })
                    end,
                })
            end
        end

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

        lspconfig.rust_analyzer.setup({
            capabilities = capabilities,
            on_attach = function(_, bufnr)
                vim.api.nvim_create_autocmd("BufWritePre", {
                    buffer = bufnr,
                    callback = function()
                        vim.cmd("RustFmt")
                    end,
                })
            end,
            settings = {
                ["rust-analyzer"] = {
                    cargo = { allFeatures = true },
                    checkOnSave = { command = "clippy" },
                    diagnostics = { enable = true },
                    assist = {
                        importGranularity = "module",
                        importPrefix = "by_self",
                    },
                    lens = { enable = true },
                },
            },
        })

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

        local custom_caps = vim.lsp.protocol.make_client_capabilities()
        custom_caps.textDocument.completion.completionItem.labelDetailsSupport = false

        lspconfig.clangd.setup({
            filetypes = { "cpp", "objcpp" },
            cmd = {
                "/opt/homebrew/opt/llvm/bin/clangd",
                "--enable-config",
                "--query-driver=/opt/homebrew/opt/llvm/bin/clang++",
            },
            capabilities = custom_caps,
            init_options = {
                clangdFileStatus = true,
                fallbackFlags = {
                    --     "-xc++",
                    "-std=c++23",
                    --     "-stdlib=libc++",
                    "-I/usr/local/include",
                    --     "-isystem", "/opt/homebrew/opt/llvm/include/c++/v1",
                    --     "-isystem", "/opt/homebrew/opt/llvm/include",
                    --     "-isystem", "/opt/homebrew/opt/llvm/lib/clang/20/include", -- adjust version
                    --     "--target=arm64-apple-macos11",                            -- IMPORTANT: match your system arch
                    --     "-I/opt/homebrew/Cellar/llvm/20.1.5/bin/../include/c++/v1",
                    --     "-I/opt/homebrew/Cellar/llvm/20.1.5/lib/clang/20/include",
                    --     "-I/Library/Developer/CommandLineTools/SDKs/MacOSX15.sdk/usr/include",
                },
                completion = { filterAndSort = true },
            },
            handlers = {
                ["textDocument/signatureHelp"] = function() end,
            },
            on_attach = function(client, bufnr)
                on_attach(client, bufnr)
                print("Clangd attached to buffer " .. bufnr)
                client.server_capabilities.documentFormattingProvider = true
            end,
        })

        lspconfig.clangd.setup({
            filetypes = { "c", "objc" },
            cmd = {
                "/opt/homebrew/opt/llvm/bin/clangd",
                "--enable-config",
                "--query-driver=/opt/homebrew/opt/llvm/bin/clang",
            },
            capabilities = custom_caps,
            init_options = {
                clangdFileStatus = true,
                fallbackFlags = {
                    --     "-xc++",
                    --     "-stdlib=libc++",
                    --     "-isystem", "/opt/homebrew/opt/llvm/include/c++/v1",
                    --     "-isystem", "/opt/homebrew/opt/llvm/include",
                    --     "-isystem", "/opt/homebrew/opt/llvm/lib/clang/20/include", -- adjust version
                    --     "--target=arm64-apple-macos11",                            -- IMPORTANT: match your system arch
                    --     "-I/opt/homebrew/Cellar/llvm/20.1.5/bin/../include/c++/v1",
                    --     "-I/opt/homebrew/Cellar/llvm/20.1.5/lib/clang/20/include",
                    --     "-I/Library/Developer/CommandLineTools/SDKs/MacOSX15.sdk/usr/include",
                },
                completion = { filterAndSort = true },
            },
            handlers = {
                ["textDocument/signatureHelp"] = function() end,
            },
            on_attach = function(client, bufnr)
                on_attach(client, bufnr)
                print("Clangd attached to buffer " .. bufnr)
                client.server_capabilities.documentFormattingProvider = true
            end,
        })
        lspconfig.ts_ls.setup({
            capabilities = capabilities,
            init_options = {
                hostInfo = "neovim",
                preferences = {
                    importModuleSpecifierPreference = "relative",
                },
            },
            on_attach = function(client, bufnr)
                on_attach(client, bufnr)
                client.server_capabilities.documentFormattingProvider = true
                vim.api.nvim_create_autocmd("BufWritePre", {
                    buffer = bufnr,
                    callback = function()
                        vim.lsp.buf.format({ async = false })
                    end,
                })
            end,
        })

        lspconfig.pyright.setup({
            capabilities = capabilities,
            settings = {
                python = {
                    analysis = {
                        autoSearchPaths = true,
                        useLibraryCodeForTypes = true,
                        diagnosticMode = "workspace",
                    },
                },
            },
            on_attach = on_attach,
        })

        lspconfig.sqlls.setup({
            cmd = { vim.fn.stdpath("data") .. "/mason/bin/sql-language-server", "up", "--method", "stdio" },
            root_dir = function()
                return vim.loop.cwd()
            end,
            capabilities = capabilities,
            settings = {
                sqlLanguageServer = {
                    formatter = {
                        tabWidth = 2,
                        keywordCase = "upper",
                        indentStyle = "standard",
                    },
                    lint = {
                        dialect = "mysql",
                    },
                },
            },
        })

        -- lspconfig.marksman.setup({
        --     capabilities = capabilities,
        --     on_attach = on_attach,
        --     filetypes = { "markdown" },
        -- })
    end,
}
