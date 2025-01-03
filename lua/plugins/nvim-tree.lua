return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
    require("nvim-tree").setup({
      sync_root_with_cwd = true,       -- Makes nvim-tree open in the current directory
      respect_buf_cwd = true,          -- Optional: syncs nvim-tree with the buffer's directory
      update_cwd = true,               -- Optional: updates Neovim's `cwd` when nvim-tree's root changes
      -- disable_netrw = true,
      -- hijack_netrw = true,       -- Hijack netrw's default file explorer functionality
      view = {
        width = 30,
        side = "left",
      },
    })
    vim.keymap.set("n", "<leader>e", ":NvimTreeFindFileToggle<CR>", { desc = "Toggle NvimTree" })
    vim.api.nvim_set_keymap("n", "<leader>t", "<cmd>NvimTreeFocus<CR>", { noremap = true, silent = true })
  end,
}
