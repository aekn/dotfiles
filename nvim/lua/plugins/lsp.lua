return {
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v3.x",
    dependencies = {
      "neovim/nvim-lspconfig",
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
    },
    config = function()
      local lsp = require("lsp-zero")
      lsp.extend_lspconfig()

      -- Setup mason
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "pyright",
        },
        handlers = {
          lsp.default_setup,
        },
      })

      -- Custom keymaps
      lsp.on_attach(function(_, bufnr)
        local map = vim.keymap.set
        map("n", "gd", vim.lsp.buf.definition, { buffer = bufnr })
        map("n", "K", vim.lsp.buf.hover, { buffer = bufnr })
        map("n", "<leader>rn", vim.lsp.buf.rename, { buffer = bufnr })
        map("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr })
      end)

      lsp.setup()

      -- CMP setup
      local cmp = require("cmp")
      cmp.setup({
        mapping = {
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-y>"] = cmp.mapping.confirm({ select = true }),
          ["<C-Space>"] = cmp.mapping.complete(),
        },
        sources = {
          { name = "nvim_lsp" },
          { name = "buffer" },
          { name = "path" },
        },
        formatting = {
          format = function(_, item)
            item.kind = "" -- no icons
            return item
          end,
        },
      })
    end,
  },

  -- Auto-formatting on save
  {
    "stevearc/conform.nvim",
    opts = {
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "black" },
        json = { "prettier" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        html = { "prettier" },
      },
    },
  },
}
