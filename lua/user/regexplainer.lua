local status_ok, regexplainer = pcall(require, "regexplainer")
if not status_ok then
  vim.notify('Failed to require "regexplainer"...')
  return
end

local config = {
  -- filetypes (i.e. extensions) in which to run the autocommand
  filetypes = {
    'python',
    'sh',
  },

  -- 'split', 'popup', 'pasteboard'
  display = 'popup',

  mappings = {
    -- toggle = 'gR',
    toggle = '',
    -- examples, not defaults:
    -- show = 'gS',
    -- hide = 'gH',
    -- show_split = 'gP',
    -- show_popup = 'gU',
  },
}
regexplainer.setup({config})
