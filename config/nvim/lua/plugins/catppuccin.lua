return {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false,
  priority = 1000,
  opts = {
    flavour = "mocha", -- Use the darkest variant
    transparent_background = true,
    custom_highlights = function()
      return {
        -- Override background colors with pure black
        -- Normal = { bg = "#000000" },
        -- NormalFloat = { bg = "#000000" },
        -- NormalNC = { bg = "#000000" },
        -- SignColumn = { bg = "#000000" },
        -- You may want to adjust more highlight groups
      }
    end,
  },
  config = function(_, opts)
    require("catppuccin").setup(opts)
    vim.cmd.colorscheme("catppuccin")
  end,
}
