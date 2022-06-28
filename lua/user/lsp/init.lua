local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  vim.notify('Failed to require "lspconfig"...')
  return
end

-- Disabled this plugin since I'm trying the internal LSP signature help (WIP).
-- require "user.lsp.lsp-signature"

-- This is the place where all the `on_attach` and other configs (setting local/buffer keymaps for the active buffer)
-- are done, and still require being "required" by LSP servers themselves.
require("user.lsp.handlers").setup()
-- This is where the actual call to the LSP installer/servers, with the `setup{}` and `on_attach` functions configured
-- above.
require "user.lsp.lsp-installer"
-- null-ls is supposed to give extra actions like formatting etc. that are currently not saupplied by the language
-- servers. Still requires a better config + keymaps (WIP)
require "user.lsp.null-ls"
