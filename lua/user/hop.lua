local status_ok, hop = pcall(require, "hop")
if not status_ok then
  vim.notify('Failed to require "hop"...')
	return
end
hop.setup()
-- moved the following mappings to whichkey.lua
-- vim.api.nvim_set_keymap("n", "<leader>h", ":HopChar2<cr>", { silent = true })
-- vim.api.nvim_set_keymap("n", "<leader>H", ":HopWord<cr>", { silent = true })
