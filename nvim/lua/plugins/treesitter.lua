return {
  "nvim-treesitter/nvim-treesitter",
  -- TODO: master is deprecated but treesitter-endwise does not work with main branch
  branch = "master",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    ensure_installed = {
      "html",
      "java",
      "javascript",
      "json",
      "lua",
      "markdown",
      "markdown_inline",
      "python",
      "vim",
      "xml",
    },
  },
  dependencies = {
    "RRethy/nvim-treesitter-endwise", -- mainly for lua 'closing end' insertion
    -- "mfussenegger/nvim-ts-hint-textobject",
    -- "windwp/nvim-ts-autotag",
  },
  config = function(_, opts)
    ---@type TSConfig
    ---@diagnostic disable-next-line: missing-fields
    require("nvim-treesitter.configs").setup({
      ensure_installed = opts.ensure_installed,
      highlight = {
        enable = true,
      },
      endwise = {
        enable = true,
      },
      indent = { enable = true },
      autopairs = { enable = true },
    })

    -- require("nvim-ts-autotag").setup()
  end,
}
