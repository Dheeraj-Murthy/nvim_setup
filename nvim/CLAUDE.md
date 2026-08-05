# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with
code in this repository.

## Overview

This is a personal Neovim configuration using **lazy.nvim** as the plugin
manager. It was originally built on LazyVim, but the LazyVim plugin import is
now **commented out** in `lua/config/lazy.lua` — the config is standalone, with
LazyVim's default options and keymaps vendored locally into
`lua/config/lazy_opts.lua` and `lua/config/lazy_maps.lua`.

Known quirk: `lazy_opts.lua` still sets `formatexpr`/`foldexpr` to
`lazyvim.util` functions, which no longer resolve since LazyVim isn't loaded.

## Code Style

Lua formatting is enforced via **StyLua** (`stylua.toml`): 4-space indentation,
120-column line width. Run before committing:

```sh
stylua lua/
```

## Architecture

### Load Order

`init.lua` bootstraps everything in strict order:

1. Disables netrw, sets `<Space>` as leader
2. `config/lazy` — lazy.nvim bootstrap; imports `plugins/` and `plugins/lsp/`
   specs (and re-requires `config/options` at its end)
3. `config/lazy_opts` — vendored LazyVim option defaults
4. `config/lazy_maps` — vendored LazyVim base keymaps (window nav, buffers,
   git, toggles)
5. `config/keymaps` — custom user keymaps
6. `config/options` — custom option overrides (updatetime=50, shiftwidth=4,
   no swapfile)
7. `config/autocmds` — autocommands

### Directory Structure

```
lua/
├── config/          # See load order above
└── plugins/
    ├── lsp/
    │   ├── lspconfig.lua  # All LSP server configs
    │   ├── mason.lua      # Mason installer
    │   └── null_ls.lua    # Disabled (returns {})
    └── *.lua              # One file per plugin or plugin group
snippets/                  # LuaSnip-compatible JSON snippets (cpp, python, js, lua, c)
```

### Key Architectural Decisions

- **Plugin specs live in `lua/plugins/`** — each file returns a lazy.nvim spec
  table. Adding a new plugin = adding a new file here. A spec returning `{}`
  disables that file (see `disable_plug.lua`, `lsp/null_ls.lua`).
- **LSP servers are configured in `lua/plugins/lsp/lspconfig.lua`** with a
  shared `on_attach` that sets Telescope-backed LSP keymaps (`gd`, `gr`, `gi`,
  `gt`, `<leader>rn`). clangd is set up **twice**: once for `cpp/objcpp`
  (clang++ driver, C++23) and once for `c/objc` (clang driver), both from
  `/opt/homebrew/opt/llvm/bin/`.
- **Formatting** — manual only (no format-on-save). `<leader>cf` calls
  `conform.format({ lsp_fallback = true })`, which uses conform formatters
  (prettier for markdown, prose-wrap at 80) or falls back to LSP.
- **Completion** uses `blink.cmp` (Tab to accept, fuzzy matching).
- **Active colorscheme** is set in `autocmds.lua`
  (`vim.cmd("colorscheme ayu")`), not in the plugin spec — change it there.
  `autocmds.lua` also sets custom highlight overrides for Snacks explorer.
- **Session management** uses `mini.sessions`; auto-saves to "autosave" on
  `VimLeavePre` and via `<leader>qq`.
- **Mac-specific keybinds** in `keymaps.lua` use `<D-...>` mappings plus
  numeric stand-in codes (e.g. `696970` for Cmd+S) sent by the terminal.
- **Performance autocmds**: Treesitter highlighting is disabled for files over
  5000 lines; `nvim .` opens Oil instead of netrw (VimEnter autocmd).

### Configured LSP Servers

| Server        | Language                                     |
| ------------- | -------------------------------------------- |
| clangd        | C/C++ (C++23, `/opt/homebrew/opt/llvm/bin/`) |
| ts_ls         | TypeScript / JavaScript                      |
| pyright       | Python                                       |
| rust_analyzer | Rust (clippy, all features)                  |
| lua_ls        | Lua                                          |
| emmet_ls      | HTML / CSS / JSX                             |
| sqlls         | SQL (MySQL dialect)                          |

### Notable Plugins

- **Snacks.nvim** — dashboard, explorer (`<leader>e`), lazygit (`<leader>gg`),
  notifications, picker
- **Telescope** — fuzzy finder (`<leader><space>` files, `<leader>/` grep,
  `<leader>t*` for buffers/keymaps/registers/marks/diagnostics)
- **Harpoon** — file marks (`<leader>hm/hf/hp/ha`)
- **Flash.nvim** — motion (`s`, `S`)
- **DAP + DAP-UI** — C/C++ debugger via LLDB (`<F1>`–`<F5>`, `<leader>d*`;
  `<leader>dc` compiles with `clang++ -g -std=c++23`)
- **CompetiTest** — competitive programming test runner (`<leader>a*`)
- **Oil.nvim** — file manager (opens when nvim is invoked with `.`)
- **mini.nvim** — surround, pairs, ai text objects, snippets, indentscope
- **Trouble.nvim** — diagnostics panel (`<leader>xx`)

### Competitive Programming Setup

`<leader>rr` compiles and runs the current C++ file with `g++-14`, reading from
`input.txt` and writing to `output.txt` (live-tailed). CompetiTest
(`<leader>a*`) provides test-case management and contest/problem reception.
