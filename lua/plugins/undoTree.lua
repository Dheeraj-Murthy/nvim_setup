return {
  "mbbill/undotree",
  lazy = false,
  config = function()
    vim.keymap.set("n", "<leader><F5>", ":UndotreeToggle<CR>", { desc = "toggle undotree" })
  end,
}
