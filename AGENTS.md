# AGENTS.md - Neovim Configuration Development Guide

This document provides comprehensive guidelines for agentic coding agents working on this Neovim configuration repository.

## Project Overview

This is a personal Neovim configuration built on top of LazyVim framework. The configuration uses Lua exclusively and follows a modular plugin architecture with lazy.nvim as the plugin manager.

## Build/Lint/Test Commands

### Formatting Commands
```bash
# Format Lua files using StyLua (configured in stylua.toml)
stylua --config-path stylua.toml .

# Format on save is enabled via conform.nvim with LSP fallback
# Manual format: <leader>cf (if available)
```

### Linting & Diagnostics
```bash
# Linting is handled by LSP servers:
# - lua_ls for Lua files (configured in .neoconf.json)
# - Other language servers for respective file types

# Check LSP diagnostics in Neovim:
:lua vim.diagnostic.open_float()
```

### Testing
```bash
# This config does not have automated tests
# Manual testing:
nvim --config ~/.config/nvim

# Test specific functionality:
nvim -c "lua require('config.lazy').check()"
```

### Single Plugin Testing
```bash
# Test a specific plugin configuration:
nvim -c "lua require('plugins/plugin_name').setup()"

# Reload plugin configuration:
:lua require('lazy').reload('plugin-name')
```

## Code Style Guidelines

### General Principles
- **No emojis in production code** (except in user-facing messages)
- **No type suppression** (`@ts-ignore`, `as any`, etc.)
- **Prefer explicit over implicit**
- **Follow LazyVim patterns** when extending functionality

### Import Patterns
```lua
-- Preferred order: built-ins -> third-party -> local modules
local vim = vim
local lspconfig = require("lspconfig")
local utils = require("config.utils")

-- Use local variables for frequently accessed nested tables
local keymap = vim.keymap.set
local api = vim.api
```

### Formatting (StyLua Configuration)
- **Indentation**: 4 spaces (configured in stylua.toml)
- **Column width**: 120 characters
- **Indent type**: Spaces only

### Naming Conventions
```lua
-- Variables: snake_case
local lsp_servers = {}
local user_options = {}

-- Functions: snake_case for general, camelCase for methods
local function setup_lsp_servers() end
local function onAttach(client, bufnr) end

-- Constants: UPPER_SNAKE_CASE
local DEFAULT_CONFIG = {}
local KEYMAPS = {}

-- Plugin configurations: lowercase with underscores
local plugins_options = {}
local lsp_config = {}
```

### Table & Module Structure
```lua
-- Plugin spec structure (LazyVim pattern)
return {
    "plugin-author/plugin-name",
    dependencies = { "dependency1", "dependency2" },
    event = { "BufReadPre", "BufNewFile" },
    opts = {
        -- Plugin options here
    },
    config = function()
        -- Plugin configuration logic
    end,
}

-- Configuration modules
local M = {}

function M.setup()
    -- Module initialization
end

function M.get_config()
    -- Return configuration
end

return M
```

### Keymap Patterns
```lua
-- Use descriptive names and groups
vim.keymap.set("n", "<leader>ff", function()
    vim.cmd("Telescope find_files")
end, { desc = "Find Files" })

-- Mode-specific keymaps with proper options
local opts = { buffer = bufnr, noremap = true, silent = true }
vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)

-- Filetype-specific autocommands
vim.api.nvim_create_autocmd("FileType", {
    pattern = "python",
    callback = function()
        local opts = { buffer = true }
        vim.keymap.set("n", "<leader>rf", ":w<CR>:!python3 %<CR>", opts)
    end,
})
```

### Error Handling
```lua
-- Always use pcall for potentially failing operations
local ok, result = pcall(function()
    require("some_module")
end)

if not ok then
    vim.notify("Failed to load module: " .. result, vim.log.levels.ERROR)
    return
end

-- Graceful fallbacks
local function safe_require(module_name)
    local ok, module = pcall(require, module_name)
    return ok and module or nil
end
```

### LSP Configuration Patterns
```lua
-- Standard LSP setup pattern
local function on_attach(client, bufnr)
    local keymap = vim.keymap.set
    local opts = { buffer = bufnr, silent = true }
    
    -- Standard LSP keymaps
    keymap("n", "gd", vim.lsp.buf.definition, opts)
    keymap("n", "K", vim.lsp.buf.hover, opts)
    keymap({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
    
    -- Format on save if supported
    if client.server_capabilities.documentFormattingProvider then
        vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.format({ async = false })
            end,
        })
    end
end

-- Server configuration
local capabilities = require("cmp_nvim_lsp").default_capabilities()
lspconfig.lua_ls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        Lua = {
            diagnostics = { globals = { "vim" } },
        },
    },
})
```

### Autocommand Patterns
```lua
-- Use specific event patterns and clear groups
local augroup = vim.api.nvim_create_augroup("MyConfig", { clear = true })

vim.api.nvim_create_autocmd("BufWritePre", {
    group = augroup,
    callback = function()
        -- Format on save logic
    end,
})
```

## File Organization

### Directory Structure
```
/Users/dheerajmurthy/.config/nvim/
├── init.lua                 # Entry point
├── stylua.toml             # Lua formatter config
├── .neoconf.json           # Neovim LSP config
├── lua/
│   ├── config/             # Core configuration modules
│   │   ├── options.lua     # Vim options
│   │   ├── keymaps.lua     # Global keymaps
│   │   ├── autocmds.lua    # Autocommands
│   │   └── lazy*.lua       # Lazy.nvim setup
│   └── plugins/            # Plugin specifications
│       ├── lsp/           # LSP-related plugins
│       └── *.lua          # Individual plugin configs
└── snippets/               # Custom snippets
```

### Plugin Configuration Rules
1. **One plugin per file** in `lua/plugins/`
2. **Use proper dependencies** declarations
3. **Follow LazyVim spec structure**
4. **Enable format on save** where appropriate
5. **Configure LSP servers** with proper capabilities

### Configuration Module Rules
1. **Keep modules focused** on single responsibilities
2. **Use lazy loading** where possible
3. **Provide sensible defaults**
4. **Document complex logic** with comments

## Development Workflow

### Adding New Plugins
1. Create new file in `lua/plugins/`
2. Follow LazyVim plugin spec structure
3. Configure proper dependencies
4. Test with minimal configuration first
5. Add to lazy-lock.json after verification

### Modifying Core Configuration
1. Check existing LazyVim defaults first
2. Use `opts` function for extensions, not replacements
3. Test changes with `nvim --clean`
4. Verify LSP integration still works

### Debugging
```lua
-- Use vim.notify for user feedback
vim.notify("Configuration loaded", vim.log.levels.INFO)

-- Debug plugin loading
:lua print(vim.inspect(require("lazy").plugins()))

-- Check LSP status
:lua vim.diagnostic.setloclist()
```

## Special Considerations

### Performance
- Use lazy loading extensively
- Disable unused features
- Configure Treesitter parsers selectively
- Use buffer-local options where possible

### Compatibility
- This config targets Neovim 0.8+
- Uses LazyVim as base framework
- Compatible with macOS development environment
- Uses Homebrew-installed tools (clangd, etc.)

### Custom Features
- Custom keymaps for macOS-style shortcuts
- Integration with external tools (tmux, iTerm2)
- Special handling for large files (disable syntax highlighting)
- Auto-save session functionality