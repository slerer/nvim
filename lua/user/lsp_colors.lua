local status_ok, colours = pcall(require, "lsp-colors")
if not status_ok then
  return
end

colours.setup {
  }
