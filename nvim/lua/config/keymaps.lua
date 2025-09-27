local map = vim.keymap.set

map("n", "<leader>w", "<cmd>write<CR>")
map("n", "<leader>ww", "<cmd>wall<CR>")
map("n", "<leader>qa", "<cmd>wa | qa<CR>")

map("x", "J", ":m '>+1<CR>gv=gv")
map("x", "K", ":m '<-2<CR>gv=gv")
map("x", "H", "<gv")
map("x", "L", ">gv")

map("x", "<leader>p", "\"_dP")


map("n", "<leader>tw", function() vim.wo.wrap = not vim.wo.wrap end)
map("n", "<leader>tn", function() vim.wo.relativenumber = not vim.wo.relativenumber end)

map("n", "<leader>tv", function()
  local cfg = vim.diagnostic.config()
  vim.diagnostic.config({ virtual_text = not cfg.virtual_text })
end)

-- buffer stuff
map("n", "<leader>bn", "<cmd>bnext<CR>")
map("n", "<leader>bp", "<cmd>bprevious<CR>")
map("n", "<leader>bd", "<cmd>bdelete<CR>")

map("n", "<leader>vd", vim.diagnostic.open_float)

map("n", "K", vim.lsp.buf.hover)
