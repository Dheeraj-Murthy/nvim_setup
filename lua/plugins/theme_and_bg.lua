return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    transparent = true,
    styles = {
      sidebars = "transparent",
      floats = "transparent",
      winbar = "transparent",
      -- comments = { fg = "#00FF00", italic = true },
    },
    on_highlights = function(hl, c)
      -- NOTE: use "TSHighlightCapturesUnderCursor" to find out what group it belongs to
      -- Override specific syntax groups with custom colors
      -- hl["@keyword"] = { fg = "#F5FF21" } -- Change keyword color (example: pink)
      -- hl["@property"] = { fg = "#00ffff" } -- Change variable color (example: light blue)
      hl.Comment = { fg = "#34a0a4", italic = true } -- Comment color and italic (example: greyish blue)
      hl["@function"] = { fg = "#00ffff" }           -- Function name color (example: green)
      hl["@function.method"] = { fg = "#8975FF" }    -- Function name color (example: green)
      hl.String = { fg = "#00ff00" }                 -- String color (example: yellow)
      hl["@variable"] = { fg = "#Ffffff" }           -- change color of variables
      hl["@property"] = { fg = "#F0C10C" }           -- change color of variables
      hl["@variable.parameter"] = { fg = "#F0C10C" } -- change color of variables
    end,
  },
}
