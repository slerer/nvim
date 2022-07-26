local M = {}

local navic_status, navic = pcall(require, "nvim-navic")
if not navic_status then
  vim.notify('Failed to require "nvim-navic"...')
end

M.winbar_filetype_exclude = {
  "help",
  "startify",
  "dashboard",
  "packer",
  "neogitstatus",
  "NvimTree",
  "Trouble",
  "alpha",
  "lir",
  "Outline",
  "spectre_panel",
  "toggleterm",
  "DressingSelect",
  "",
}

local get_filename = function()
  local filename = vim.fn.expand "%:t"
  local extension = vim.fn.expand "%:e"
  local f = require "user.utils"

  if not f.isempty(filename) then
    local file_icon, file_icon_color = require("nvim-web-devicons").get_icon_color(
      filename,
      extension,
      { default = true }
    )

    local hl_group = "FileIconColor" .. extension

    vim.api.nvim_set_hl(0, hl_group, { fg = file_icon_color })
    if f.isempty(file_icon) then
      file_icon = ""
      file_icon_color = ""
    end

    return " " .. "%#" .. hl_group .. "#" .. file_icon .. "%*" .. " " .. "%#LineNr#" .. filename .. "%*"
  end
end

local function get_modified()
  if require("user.utils").get_buf_option "mod" then
    local mod = require("user.icons").git.Mod
    return "%#WinBarFilename#" .. mod .. " " .. "%t" .. "%*"
  end
  return "%#WinBarFilename#" .. "%t" .. "%*"
end

local function get_location()
  local location = navic.get_location()
  if not require("user.utils").isempty(location) then
    return "%#WinBarContext#" .. " " .. require("user.icons").ui.ChevronRight .. " " .. location .. "%*"
  end
  return ""
end

local get_gps = function()
  local status_gps_ok, gps = pcall(require, "nvim-gps")
  if not status_gps_ok then
    vim.notify("failed to require 'nvim-gps'...")
    vim.opt.winbar = "%f"
  end

  local status_ok, gps_location = pcall(gps.get_location, {})
  if not status_ok then
    return ""
  end

  if not gps.is_available() or gps_location == "error" then
    return ""
  end

  if not require("user.utils").isempty(gps_location) then
    return require("user.icons").ui.ChevronRight .. " " .. gps_location
  else
    return ""
  end
end

local excludes = function()
  if vim.tbl_contains(M.winbar_filetype_exclude, vim.bo.filetype) then
    vim.opt_local.winbar = nil
    return true
  end
  return false
end

function M.get_winbar()
  if excludes() then
    return ""
  end
  if navic_status then
    return "%#WinBarSeparator#"
      .. "%="
      .. "%*"
      .. get_modified()
      .. get_location()
      .. "%#WinBarSeparator#"
      .. "%*"
  else
    return "%#WinBarSeparator#" .. "%=" .. "%*" .. get_modified() .. "%#WinBarSeparator#" .. "%*"
  end
end

-- M.get_winbar = function()
--   if excludes() then
--     return
--   end
--   local f = require "user.utils"
--   local value = get_filename()
--
--   local gps_added = false
--   if not f.isempty(value) then
--     local gps_value = get_gps()
--     value = value .. " " .. gps_value
--     if not f.isempty(gps_value) then
--       gps_added = true
--     end
--   end
--
--   if not f.isempty(value) and f.get_buf_option "mod" then
--     local mod = "%#LineNr#" .. require("user.icons").ui.Circle .. "%*"
--     if gps_added then
--       value = value .. " " .. mod
--     else
--       value = value .. mod
--     end
--   end
--
--   local status_ok, _ = pcall(vim.api.nvim_set_option_value, "winbar", value, { scope = "local" })
--   if not status_ok then
--     return
--   end
-- end

-- vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
return M
