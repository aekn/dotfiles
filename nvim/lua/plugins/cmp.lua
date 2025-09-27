return {
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
    },
    config = function()
      local cmp, luasnip = require("cmp"), require("luasnip")
      cmp.setup({
        completion = { completeopt = "menu,menuone,noselect" },
        snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = false }),
          ["<Tab>"] = function(fb)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fb()
            end
          end,
          ["<S-Tab>"] = function(fb)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fb()
            end
          end,
        }),
        sources = {
          { name = "nvim_lsp" }, { name = "path" }, { name = "buffer" }, { name = "luasnip" },
        },
      })
    end,
  },
}
