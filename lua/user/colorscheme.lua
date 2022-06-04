vim.o.background = "dark"
vim.g.gruvbox_flat_style = "hard"
vim.g.gruvbox_sidebars = { "qf", "vista_kind", "terminal", "packer" }
-- local colorscheme = "darkplus"
-- local colorscheme = "gruvbox"
-- local colorscheme = "gruvbox8_hard"
-- vim.cmd[[au VimEnter * highlight ToDo ctermbg=None]]
local colorscheme = "gruvbox-flat"

-- TODO: From old .vimrc config - need to convert to lua API and add these:
-- let g:gruvbox_invert_signs='1'
-- let g:gruvbox_invert_selection='0'
-- let g:gruvbox_contrast_dark = 'hard'
-- set background=dark
-- colorscheme gruvbox
-- highlight Comment cterm=italic gui=italic

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end
