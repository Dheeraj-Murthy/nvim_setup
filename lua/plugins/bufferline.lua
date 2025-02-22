return {
  "akinsho/bufferline.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local bufferline = require("bufferline")

    local function toggle_bufferline()
      local buffers = vim.fn.getbufinfo({ buflisted = 1 }) -- Get listed buffers
      if #buffers > 1 then
        vim.opt.showtabline = 2                            -- Always show tabline
      else
        vim.opt.showtabline = 0                            -- Hide tabline
      end
    end

    bufferline.setup({
      options = {
        separator_style = { " ", " " }, -- Try a preset style
        indicator = {
          icon = { '▎', '➤' }, -- Ensure your font supports this character
          style = 'icon',
        },
      },
    })

    -- Auto-toggle bufferline when opening or closing buffers
    vim.api.nvim_create_autocmd({ "BufAdd", "BufDelete" }, {
      callback = toggle_bufferline,
    })

    -- Run once on startup
    toggle_bufferline()
  end
}
