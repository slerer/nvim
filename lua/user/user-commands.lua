local status_ok, _ = pcall(require, "nvim-gps")
if not status_ok then
  vim.notify('Failed to require "nvim-gps"...')
	return
end

vim.api.nvim_create_user_command(
  'WhereAmI',
  function()
    print(require("nvim-gps").get_location())
  end,
  {desc = 'Echoes the location in the code.'})

vim.cmd [[ command! KillWhitespace :normal! :%s/ *$//<cr>:noh<cr><c-o> ]]
