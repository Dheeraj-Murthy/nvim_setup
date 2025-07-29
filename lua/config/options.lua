-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options hereafter
vim.opt.updatetime = 50
vim.opt.termguicolors = true
vim.g.lazyvim_completion_disabled = true
-- vim.o.winbar = "%f<LeftMouse>
vim.g.mapleader = " "
vim.g.tmux_navigator_no_wrap = 1             -- Prevents cycling between tmux panes
vim.g.tmux_navigator_disable_when_zoomed = 1 -- Fixes issues when a pane is zoomed
vim.opt.statuscolumn = ""
vim.opt.shiftwidth = 4                       -- Size of an indent
vim.opt.swapfile = false
