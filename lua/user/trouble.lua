local trouble_status_ok, trouble = pcall(require, "trouble")
if not trouble_status_ok then
  vim.notify('Failed to require "trouble"...')
	return
end

trouble.setup({})


-- vim.api.nvim_create_user_command(
--   'Tn',
--   function()
--     require('trouble').next({skip_groups = true, jump = true})
--   end,
--   {desc = 'goto next Trouble item'})
--
-- vim.api.nvim_create_user_command(
--   'Tp',
--   function()
--     require('trouble').previous({skip_groups = true, jump = true})
--   end,
--   {desc = 'goto previous Trouble item'})

vim.cmd [[ command! Tn :normal! :lua require('trouble').next({skip_groups = true}) ]]
vim.cmd [[ command! Tp :normal! :lua require('trouble').previous({skip_groups = true}) ]]

