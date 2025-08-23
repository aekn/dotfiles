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
map("n", "<leader>j", '5j', { desc = "move down faster" })
map("n", "<leader>k", '5k', { desc = "move up faster" })


vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.keymap.set("n", "<leader>wp", function()
      vim.cmd("write")
      local input = vim.fn.expand("%")
      local output = vim.fn.expand("%:r") .. ".pdf"
      local cmd = string.format("pandoc %s -o %s --pdf-engine=xelatex", input, output)
      vim.fn.jobstart(cmd, {
        stdout_buffered = true,
        stderr_buffered = true,
        on_exit = function(_, code, _)
          if code == 0 then
            print("PANDICCED")
          else
            print("FAILED 2 PANDIC IT")
          end
        end,
      })
    end, { buffer = true, desc = "Convert Markdown to PDF with Pandoc + XeLaTeX" })
  end,
})
