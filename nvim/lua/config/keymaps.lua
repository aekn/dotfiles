local map = vim.keymap.set
local builtin = require("telescope.builtin")

-- NetRW (Ex) file explorer
map("n", "<leader>pv", vim.cmd.Ex, { desc = "Open netrw" })

-- Telescope keymaps
map("n", "<leader>ts", builtin.find_files, { desc = "Telescope: Find Files" })
map("n", "<leader>tg", function()
  builtin.grep_string({ search = vim.fn.input("Grep > ") })
end, { desc = "Telescope: Grep input string" })
map("n", "<leader>vd", vim.diagnostic.open_float, { desc = "show diagnostic" })
