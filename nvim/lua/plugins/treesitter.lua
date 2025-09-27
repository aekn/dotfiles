return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      ensure_installed = { "lua", "vim", "bash", "python", "markdown", "markdown_inline" },
      highlight = { enable = true, additional_vim_regex_highlighting = false },
      indent = { enable = true, disable = { "python" } },
    },
    config = function(_, opts) require("nvim-treesitter.configs").setup(opts) end,
  },
}
