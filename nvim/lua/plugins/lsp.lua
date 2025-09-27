return {
  { "williamboman/mason.nvim", build = ":MasonUpdate", cmd = { "Mason", "MasonInstall" }, opts = {} },

  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    event = "VeryLazy",
    opts = {
      ensure_installed = {
        "pyright", "ruff", "bash-language-server", "lua-language-server",
      },
      run_on_start = true,
    },
  },

  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "hrsh7th/cmp-nvim-lsp" },
    config = function()
      local caps = require("cmp_nvim_lsp").default_capabilities()

      local function cfg(name, opts)
        opts = opts or {}
        opts.capabilities = vim.tbl_deep_extend("force", {}, caps, opts.capabilities or {})
        vim.lsp.config(name, opts)
      end

      cfg("pyright")
      cfg("ruff", {})

      cfg("bashls")
      cfg("lua_ls", {
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
            workspace   = { checkThirdParty = false },
            telemetry   = { enable = false },
          },
        },
      })

      vim.lsp.enable({ "pyright", "ruff", "bashls", "lua_ls" })

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client and client.name == "ruff" then
            client.server_capabilities.hoverProvider = false
          end
        end,
        desc = "Disable Ruff hover in favor of Pyright",
      })
    end,
  },
}

