local M = {}

function WinBar()
  local buf = vim.api.nvim_win_get_buf(vim.g.statusline_winid)
  local path = vim.api.nvim_buf_get_name(buf)
  path = path:gsub(os.getenv("HOME"), "~")
  local elems = vim.split(path, "/", { trimempty = true })
  return "%#WinBarPath#" .. table.concat(elems, " %#WinBarSep# %#WinBarPath#") .. " %#WinBar#"
end

-- inspect something
function Inspect(item)
  vim.pretty_print(item)
end

function M.executable(name)
  if vim.fn.executable(name) > 0 then
    return true
  end

  return false
end

function M.may_create_dir()
  local fpath = vim.fn.expand('<afile>')
  local parent_dir = vim.fn.fnamemodify(fpath, ":p:h")
  local res = vim.fn.isdirectory(parent_dir)

  if res == 0 then
    vim.fn.mkdir(parent_dir, 'p')
  end
end

function M.multilineCommand(command)
  for line in vim.gsplit(command, "\n", true) do
    vim.cmd(vim.trim(line))
  end
end

function M.lua_map(args)
  local opts = { noremap = true, silent = true }
  if args.bufnr then
    vim.api.nvim_buf_set_keymap(
      args.bufnr,
      args.mode or "n",
      args.keys,
      "<cmd>lua " .. args.mapping .. "<CR>",
      opts
    )
  else
    vim.api.nvim_set_keymap(
      args.mode or "n",
      args.keys,
      "<cmd>lua " .. args.mapping .. "<CR>",
      opts
    )
  end
end

function M.get_python_path(workspace)
  -- Use activated virtualenv.
  local util = require("lspconfig/util")

  local path = util.path
  if vim.env.VIRTUAL_ENV then
    return path.join(vim.env.VIRTUAL_ENV, "bin", "python")
  end

  -- Find and use virtualenv in workspace directory.
  for _, pattern in ipairs({ "*", ".*" }) do
    local match = vim.fn.glob(path.join(workspace or vim.fn.getcwd(), pattern, "pyvenv.cfg"))
    if match ~= "" then
      return path.join(path.dirname(match), "bin", "python")
    end
  end

  -- Fallback to system Python.
  return vim.fn.exepath("python3") or vim.fn.exepath("python") or "python"
end

function M.kitty_scrollback()
  vim.cmd("silent! write! /tmp/kitty_scrollback")

  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_set_current_buf(buf)
  local data = io.open("/tmp/kitty_scrollback", "r"):read("*a"):gsub("\n", "\r\n")
  local term = vim.api.nvim_open_term(0, {})
  vim.api.nvim_chan_send(term, data)

    -- vim.api.nvim_buf_delete(buf, {force = true})
end

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

local function parseInt(str)
    return str:match("^%-?%d+$")
end

function AppendLoremPicsumUrl()
    local width = parseInt(vim.fn.input("width: "))
    local height = parseInt(vim.fn.input("height: "))

    if width and height then
        local curl = require("plenary.curl")

        local res = curl.get("https://picsum.photos/" .. width .. "/" .. height, {})
        local url = res.headers[3]:sub(11)

        local cursor = vim.api.nvim_win_get_cursor(0)
        local line = vim.api.nvim_get_current_line()
        local nline = line:sub(0, cursor[2] + 1) .. url .. line:sub(cursor[2] + 2)

        vim.api.nvim_set_current_line(nline)
        vim.api.nvim_win_set_cursor(0, { cursor[1], cursor[2] + url:len() })
    end
end

vim.cmd("command! LoremPicsum silent lua AppendLoremPicsumUrl()")

return M
