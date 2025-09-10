return {
  'MeanderingProgrammer/render-markdown.nvim',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-mini/mini.nvim', -- if you use the mini.nvim suite
    -- 'nvim-mini/mini.icons', -- if you use standalone mini plugins
    -- 'nvim-tree/nvim-web-devicons', -- if you prefer nvim-web-devicons
  },
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  opts = {
    render_modes = true,
    heading = {
      border = true,
      border_virtual = true,
      sign = false,
      icons = { '' }
    },
    indent = {
      enabled = true,
      icon = '',
      skip_level = 1,
    },
    code = {
      style = 'normal',
      border = 'thick',
    },
  },
}
