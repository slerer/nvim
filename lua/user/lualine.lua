local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
  return
end

local status_gps_ok, gps = pcall(require, "nvim-gps")
if not status_gps_ok then
  return
end

local hide_in_width = function()
  return vim.fn.winwidth(0) > 80
end

local icons = require "user.icons"

local diagnostics = {
  "diagnostics",
  sources = { "nvim_diagnostic" },
  sections = { "error", "warn" },
  symbols = { error = icons.diagnostics.Error .. " ", warn = icons.diagnostics.Warning .. " " },
  colored = true,
  update_in_insert = false,
  always_visible = true,
  -- separator = { left = '', right = '' },
}

local diff = {
  "diff",
  colored = true,
  symbols = { added = icons.git.Add .. " ", modified = icons.git.Mod .. " ", removed = icons.git.Remove .. " " }, -- changes diff symbols
  cond = hide_in_width,
}

local mode = {
  "mode",
  fmt = function(str)
    -- local nvim_mode = "-- " .. str .. " --"
    local nvim_mode = str
    if vim.o.paste then
      nvim_mode = nvim_mode .. " (paste)"
    end
    return nvim_mode
  end,
  separator = { left = '', right = '' },
  -- separator = { left = '' },
  -- padding = { right = 1 },
}

local filename = {
  "filename",
  file_status = true,      -- Displays file status (readonly status, modified status)
  path = 3,                -- 0: Just the filename
                           -- 1: Relative path
                           -- 2: Absolute path
                           -- 3: Absolute path, with tilde as the home directory

  shorting_target = 40,    -- Shortens path to leave 40 spaces in the window for other components. (terrible name, any suggestions?)
  symbols = {
    modified = "[+]",      -- Text to show when the file is modified.
    readonly = "[-]",      -- Text to show when the file is non-modifiable or readonly.
    unnamed = "[No Name]", -- Text to show for unnamed buffers.
  }
}

local filetype = {
  "filetype",
  colored = true,   -- Displays filetype icon in color if set to true
  icons_enabled = true,
  icon_only = false, -- Display only an icon for filetype
  -- icon = { align = 'right' }, -- Display filetype icon on the right hand side
  -- icon = nil,
}

local fileformat = {
  "fileformat",
  colored = true,
  icons_enabled = true,
  icon_only = true,
  -- padding = { left = 1, right = 0 },
}

local branch = {
  "branch",
  icons_enabled = true,
  icon = "",
  -- separator = { right = '' },
}

local location = {
  "location",
  -- padding = 0,
}

-- cool function for progress
local progress = function()
  local current_line = vim.fn.line "."
  local total_lines = vim.fn.line "$"
  local chars = { "██", "▇▇", "▆▆", "▅▅", "▄▄", "▃▃", "▂▂", "▁▁", "__" }
  local line_ratio = current_line / total_lines
  local index = math.ceil(line_ratio * #chars)
  return chars[index]
end

local spaces = function()
  return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
end

local nvim_gps = function()
  local gps_location = gps.get_location()
  if gps_location == "error" then
    return ""
  else
    return gps.get_location()
  end
end

-- TODO: find out what is overriding this
vim.opt.laststatus = 3

lualine.setup {
  options = {
    icons_enabled = true,
    theme = "auto",
    -- component_separators = { left = '', right = ''},
    component_separators = '|',
    -- component_separators = '',
    section_separators = { left = '', right = '' },
    -- section_separators = { left = '', right = ''},
    -- section_separators = { left = "", right = "" },
    disabled_filetypes = { "alpha", "dashboard", "NvimTree", "Outline", "toggleterm" },
    -- disabled_filetypes = { "alpha", "dashboard", "toggleterm" },
    always_divide_middle = false,
    globalstatus = true,
  },
  sections = {
    lualine_a = { mode },
    lualine_b = { filetype, branch, diagnostics },
    lualine_c = { { nvim_gps, cond = hide_in_width }},
    -- lualine_c = { filename,  diagnostics , { nvim_gps, cond = hide_in_width }},
    lualine_x = { filename, diff, spaces, fileformat, "encoding" },
    lualine_y = { location },
    lualine_z = { { 'progress', padding = { left = 0, right = 1 } } },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  extensions = {},
}

vim.opt.laststatus = 3
