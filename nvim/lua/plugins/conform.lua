return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    opts = {
      formatters_by_ft = {
        python = { "black" },
        lua = { "stylua" },
        sh = { "shfmt" },
        markdown = { "prettier" },
      },
      format_on_save = function(buf)
        return vim.bo[buf].filetype == "python" and { lsp_fallback = false, timeout_ms = 2000 } or nil
      end,
    },
  },
}
