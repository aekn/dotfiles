return {
  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFindFile" },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      {
        "<leader>e",
        function()
          require("nvim-tree").setup({
            view = {
              float = {
                enable = true,
                quit_on_focus_loss = true,
                open_win_config = function()
                  local columns = vim.o.columns
                  local lines   = vim.o.lines - vim.o.cmdheight
                  local width   = math.floor(columns * 0.6)
                  local height  = math.floor(lines * 0.7)
                  local row     = math.floor((lines - height) * 0.5)
                  local col     = math.floor((columns - width) * 0.5)
                  return {
                    relative = "editor",
                    border   = "rounded",
                    row = row, col = col, width = width, height = height,
                  }
                end,
              },
            },
            actions = { open_file = { quit_on_open = true,  resize_window = true } },
          })
          require("nvim-tree.api").tree.toggle({ find_file = true, focus = true })
        end,
        desc = "NvimTree: popup (centered float)",
      },
      {
        "<leader>E",
        function()
          require("nvim-tree").setup({
            view = { float = { enable = false }, side = "left", width = 28 },
            actions = { open_file = { quit_on_open = false } },
          })
          require("nvim-tree.api").tree.toggle({ find_file = true, focus = true })
        end,
        desc = "NvimTree: sidebar (left)",
      },
    },
    opts = {
      hijack_netrw = true,
      sync_root_with_cwd = true,
      update_focused_file = { enable = true, update_root = true },
      renderer = {
        indent_markers = { enable = true },
        highlight_git = false,
        icons = { show = { git = false, folder_arrow = false } },
      },
      diagnostics = { enable = false },
      git = { enable = false },
      filesystem_watchers = { enable = true },
    },
  },
}

