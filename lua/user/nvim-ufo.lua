local status_ok, ufo = pcall(require, "ufo")
if not status_ok then
  vim.notify('Failed to require "nvim-ufo"...')
  return
end

vim.wo.foldcolumn = '1'
vim.wo.foldlevel = 99 -- feel free to decrease the value
vim.wo.foldenable = true

ufo.setup()
