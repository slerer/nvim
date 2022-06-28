local shade_status_ok, shade = pcall(require"shade")
if not shade_status_ok then
  vim.notify('Failed to require "shade"...')
	return
end

shade.setup({
  overlay_opacity = 50,
  opacity_step = 1,
  keys = {
    brightness_up    = '<c-=>',
    brightness_down  = '<c-->',
    toggle           = '<leader>s',
  }
})

