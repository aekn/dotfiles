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
      -- Good UX for completion popups

      vim.o.completeopt = "menu,menuone,noselect"

      -- OPTIONAL: community snippets for many languages
      --   :Lazy install rafamadriz/friendly-snippets (or add as a dep in your plugin spec)
      pcall(function()
        require("luasnip.loaders.from_vscode").lazy_load()
      end)

      local cmp = require("cmp")
      local luasnip = require("luasnip")

      -- helper: is there a word before cursor?
      local has_words_before = function()
        local line, col = (table.unpack or unpack)(vim.api.nvim_win_get_cursor(0))
        if col == 0 then return false end
        local prev = vim.api.nvim_buf_get_text(0, line - 1, col - 1, line - 1, col, {})[1]
        return not prev:match("%s")
      end

      cmp.setup({
        preselect = cmp.PreselectMode.None,
        mapping = cmp.mapping.preset.insert({
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-y>"] = cmp.mapping.confirm({ select = true }),
          ["<C-Space>"] = cmp.mapping.complete(),

          -- TAB behavior
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { "i", "s" }),

          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),

        sources = {
          { name = "nvim_lsp" },
          { name = "path" },
          { name = "buffer" },
          { name = "luasnip" }, -- keep this if you use snippets
        },

        -- Keep your “no icons” style
        formatting = {
          format = function(_, item)
            item.kind = ""
            return item
          end,
        },

        -- Optional: nicer docs window
        window = {
          documentation = cmp.config.window.bordered(),
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

  -- Pair stuff that needs to be paired
  {
    "echasnovski/mini.pairs",
    event = "InsertEnter",
    config = function()
      local mp = require("mini.pairs")

      -- Right-neighbor blacklist from your skip_next:
      -- [%w%%%'%[%"%.%`%$]
      local right_blacklist = "[^%w%%%'%[%%\"%.%`%$]"

      mp.setup({
        modes = { insert = true, command = true, terminal = false }, -- :contentReference[oaicite:1]{index=1}

        mappings = {
          -- Open/close brackets
          ["("] = { action = "open", pair = "()", neigh_pattern = "[^\\]" .. right_blacklist },
          [")"] = { action = "close", pair = "()", neigh_pattern = "[^\\]" .. right_blacklist },
          ["["] = { action = "open", pair = "[]", neigh_pattern = "[^\\]" .. right_blacklist },
          ["]"] = { action = "close", pair = "[]", neigh_pattern = "[^\\]" .. right_blacklist },
          ["{"] = { action = "open", pair = "{}", neigh_pattern = "[^\\]" .. right_blacklist },
          ["}"] = { action = "close", pair = "{}", neigh_pattern = "[^\\]" .. right_blacklist },

          -- Quotes: keep the plugin defaults but add the right-char check
          ['"'] = { action = "closeopen", pair = '""', neigh_pattern = "[^\\]" .. right_blacklist, register = { cr = false } },
          ["'"] = { action = "closeopen", pair = "''", neigh_pattern = "[^%a\\]" .. right_blacklist, register = { cr = false } },
          ["`"] = { action = "closeopen", pair = "``", neigh_pattern = "[^\\]" .. right_blacklist, register = { cr = false } },
        },
      })

      -- mini.pairs doesn’t have a built-in "markdown=true"; easiest is to unmap backtick *in markdown buffers*.
      -- You can later add smarter logic if you like.
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function()
          -- Remove the buffer-local backtick mapping
          MiniPairs.unmap_buf(0, "i", "`", "``") -- :contentReference[oaicite:2]{index=2}
        end,
      })
    end,
  }
}
