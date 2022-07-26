local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
  vim.notify('Failed to require "nvim-lsp-installer"...')
  return
end

-- Register a handler that will be called for all installed servers.
-- Alternatively, you may also register handlers on specific server instances instead (see example below).
lsp_installer.on_server_ready(function(server)
  -- setting the `opts` for invoking the server's setup at the end of this callback
  local opts = {
    flags = {
      debounce_text_changes = 150,
    },
    -- get the `on_attach` defined from `user.lsp.handlers` per server type
    on_attach = require("user.lsp.handlers").on_attach,
    -- update the handlers' capabilities. Maybe requires setting up code formatting to enable it?
    capabilities = require("user.lsp.handlers").capabilities,
  }

  if server.name == "jsonls" then
    local jsonls_opts = require "user.lsp.settings.jsonls"
    opts = vim.tbl_deep_extend("force", jsonls_opts, opts)
  end

  if server.name == "sumneko_lua" then
    local sumneko_opts = require "user.lsp.settings.sumneko_lua"
    opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
  end

  if server.name == "pyright" then
    local pyright_opts = require "user.lsp.settings.pyright"
    opts = vim.tbl_deep_extend("force", pyright_opts, opts)
  end

  if server.name == "pylsp" then
    local pylsp_opts = require "user.lsp.settings.pylsp"
    opts = vim.tbl_deep_extend("force", pylsp_opts, opts)
  end

  -- This setup() function is exactly the same as lspconfig's setup function.
  -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
  server:setup(opts)
end)
