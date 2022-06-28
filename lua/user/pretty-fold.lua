local status_ok, pretty_fold = pcall(require, "pretty-fold")
if not status_ok then
  vim.notify('Failed to require "pretty-fold"...')
  return
end

pretty_fold.setup({})

local preview_status_ok, preview = pcall(require, "pretty-fold.preview")
if not preview_status_ok then
  vim.notify('Failed to require "pretty-fold"...')
  return
end

preview.setup({})
