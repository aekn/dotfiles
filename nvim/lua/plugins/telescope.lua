return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("telescope").setup({
      defaults = {
        -- optional customization
        layout_strategy = "horizontal",
        sorting_strategy = "descending",
      },
    })
  end,
}
