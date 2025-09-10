return {
  {
    "folke/tokyonight.nvim",
    priority = 1000,
    lazy = false,
    config = function()
      require("tokyonight").setup({
        style = "night", -- options: "storm", "moon", "night", "day"
        transparent = false,
        terminal_colors = true,
        styles = {
          comments = { italic = true },
          keywords = { italic = false },
          functions = {},
          variables = {},
        },
        sidebars = { "qf", "help", "NvimTree", "terminal" },
        dim_inactive = false,
      })
      vim.cmd("colorscheme tokyonight-night")
    end,
  },
}
