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

  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false, -- snacks recommends early setup
    opts = {
      -- lean set
      bigfile      = { enabled = true },
      quickfile    = { enabled = true },
      bufdelete    = { enabled = true },
      input        = { enabled = true },
      rename       = { enabled = true },

      -- explicitly off to avoid overlap / bloat
      picker       = { enabled = false },
      explorer     = { enabled = false },
      indent       = { enabled = false },
      scope        = { enabled = false },
      dim          = { enabled = false },
      notifier     = { enabled = false },
      statuscolumn = { enabled = false },
      dashboard    = { enabled = false },
      image        = { enabled = false },
      animate      = { enabled = false },
      scroll       = { enabled = false },
      zen          = { enabled = false },
      gitbrowse    = { enabled = false },
    },
  },
}
