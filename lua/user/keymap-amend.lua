local keymap_amend_status_ok, _ = pcall(require"keymap-amend")
if not keymap_amend_status_ok then
	return
end

local M = {}
M.util = {}
M.util.keymap = {}

---Wrapper around vim.keymap.set() function. It accepts in the {opts} parameter
---table an additional option:
--- - requires: (string) A module name. If this module is not available the keymap
---   won't be set.
---Example:
---    keymap.set('n', '<leader>la', function()
---        require('lspsaga.codeaction').code_action()
---    end, { requires = 'lspsaga' })
M.util.keymap.set = function (...)
   local decision = true -- The decision to set keymap or not.
   local opts = select(-1, ...)
   if type(opts) == 'table' and opts.requires then
      decision, _ = pcall(require, opts.requires)
      opts.requires = nil
   end
   if decision then vim.keymap.set(...) end
end

M.util.keymap.amend = require('keymap-amend')

return M
