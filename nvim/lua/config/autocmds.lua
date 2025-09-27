local aug = vim.api.nvim_create_augroup("UserAutoCmds", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  group = aug,
  pattern = { "help", "man", "lspinfo", "qf", "checkhealth", "startuptime" },
  callback = function(ev)
    vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = ev.buf, silent = true })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = aug,
  pattern = "python",
  callback = function()
    vim.opt_local.shiftwidth  = 4
    vim.opt_local.tabstop     = 4
    vim.opt_local.colorcolumn = "88"
  end,
})

vim.api.nvim_create_user_command("PurgeUndo", function(opts)
  local days = tonumber(opts.args) or 90
  local undodir = (vim.opt.undodir:get() or {})[1]
  if not undodir or undodir == "" then
    vim.notify("PurgeUndo: undodir is not set.", vim.log.levels.WARN)
    return
  end
  local cutoff = os.time() - (days * 24 * 60 * 60)
  local uv = vim.uv or vim.loop
  local removed, total = 0, 0
  for name, _ in vim.fs.dir(undodir) do
    local path = undodir .. "/" .. name
    local st = uv.fs_stat(path)
    if st and st.mtime and st.mtime.sec < cutoff then
      os.remove(path)
      removed = removed + 1
    end
    total = total + 1
  end
  vim.notify(("PurgeUndo: removed %d of %d files older than %d days"):format(removed, total, days))
end, { nargs = "?", desc = "Delete undo files older than N days (default 90)" })
