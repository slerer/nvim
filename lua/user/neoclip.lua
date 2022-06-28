local status_ok, neoclip = pcall(require, "neoclip")
if not status_ok then
  vim.notify('Failed to require "neoclip"...')
  return
end

neoclip.setup({})
