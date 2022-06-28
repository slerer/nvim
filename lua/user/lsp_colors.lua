local status_ok, colours = pcall(require, "lsp-colors")
if not status_ok then
  vim.notify('Failed to require "lsp-colors"...')
  return
end

colours.setup {
  }
