-- local fn = vim.fn

local M = {}

-- -- inspect something
-- function Inspect(item)
--   vim.pretty_print(item)
-- end

-- function M.executable(name)
--   if fn.executable(name) > 0 then
--     return true
--   end
--
--   return false
-- end
--
-- function M.may_create_dir()
--   local fpath = fn.expand('<afile>')
--   local parent_dir = fn.fnamemodify(fpath, ":p:h")
--   local res = fn.isdirectory(parent_dir)
--
--   if res == 0 then
--     fn.mkdir(parent_dir, 'p')
--   end
-- end

vim.cmd [[
  function! Test()
    %SnipRun
    call feedkeys("\<esc>`.")
  endfunction

  function! TestI()
    let b:caret = winsaveview()
    %SnipRun
    call winrestview(b:caret)
  endfunction
]]

function M.sniprun_enable()
  vim.cmd [[
    %SnipRun

    augroup _sniprun
     autocmd!
     autocmd TextChanged * call Test()
     autocmd TextChangedI * call TestI()
    augroup end
  ]]
  vim.notify "Enabled SnipRun"
end

function M.disable_sniprun()
  M.remove_augroup "_sniprun"
  vim.cmd [[
    SnipClose
    SnipTerminate
    ]]
  vim.notify "Disabled SnipRun"
end

function M.toggle_sniprun()
  if vim.fn.exists "#_sniprun#TextChanged" == 0 then
    M.sniprun_enable()
  else
    M.disable_sniprun()
  end
end

function M.remove_augroup(name)
  if vim.fn.exists("#" .. name) == 1 then
    vim.cmd("au! " .. name)
  end
end

vim.cmd [[ command! SnipRunToggle execute 'lua require("user.utils").toggle_sniprun()' ]]

-- get length of current word
function M.get_word_length()
  local word = vim.fn.expand "<cword>"
  return #word
end

function M.toggle_option(option)
  local value = not vim.api.nvim_get_option_value(option, {})
  vim.opt[option] = value
  vim.notify(option .. " set to " .. tostring(value))
end

function M.break_multi_lines(s)
  local t = {}

  for chunk in string.gmatch(s, "[^\n]+") do
      t[#t+1] = chunk
  end

  return t
end

function M.parse_trove_url(opts)
  -- TODO: add error handling, maybe also helper function to also handle stash and github.pie urls for gitlinker?
  local line = opts.line
  local new_pfx = opts.new_pfx or "https://trove.apple.com/dataset/"
  local old_pfx = opts.old_pfx or "trove://"

  local url = string.match(line, '"(.+@.+)"')

  return url:gsub(old_pfx, new_pfx):gsub("@", "/")
end

function M.open_trove_url(opts)
  local url = M.parse_trove_url(opts)
  vim.cmd("!open " .. url)
end

return M
