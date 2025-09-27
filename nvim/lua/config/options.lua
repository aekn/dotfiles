vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.clipboard = "unnamedplus"
vim.opt.termguicolors = true

vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.smartindent = true
vim.opt.wrap = false

vim.opt.signcolumn = "yes"

vim.opt.cursorline = true

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.hlsearch = false

vim.opt.scrolloff = 8

vim.diagnostic.config({
  virtual_text = false,
  signs = true,
  underline = false,
  update_in_insert = false,
  severity_sort = true,
  float = { border = "rounded", source = "if_many", header = "", prefix = "" },
})

local undodir = vim.fn.stdpath("state") .. "/undo"
vim.fn.mkdir(undodir, "p")
vim.opt.undofile = true
vim.opt.undodir = undodir
vim.opt.undolevels = 10000


vim.opt.completeopt = "menu,menuone,noselect"


vim.opt.confirm = true
