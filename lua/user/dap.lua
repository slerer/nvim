local dap_status_ok, dap = pcall(require"dap")
if not dap_status_ok then
	return
end

local dap_ui_status_ok, dapui = pcall(require"dapui")
if not dap_ui_status_ok then
	return
end

dapui.setup {
  icons = { expanded = "▾", collapsed = "▸" },
  mappings = {
    -- Use a table to apply multiple mappings
    expand = { "<CR>", "<2-LeftMouse>" },
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
    toggle = "t",
  },
  sidebar = {
    -- You can change the order of elements in the sidebar
    elements = {
      -- Provide as ID strings or tables with "id" and "size" keys
      {
        id = "scopes",
        size = 0.25, -- Can be float or integer > 1
      },
      { id = "breakpoints", size = 0.25 },
      -- { id = "stacks", size = 0.25 },
      -- { id = "watches", size = 00.25 },
    },
    size = 40,
    position = "right", -- Can be "left", "right", "top", "bottom"
  },
  tray = {
    -- elements = {},
    elements = { "repl" },
    size = 10,
    -- position = "bottom", -- Can be "left", "right", "top", "bottom"
  },
  floating = {
    max_height = nil, -- These can be integers or a float between 0 and 1.
    max_width = nil, -- Floats will be treated as percentage of your screen.
    border = "rounded", -- Border style. Can be "single", "double" or "rounded"
    mappings = {
      close = { "q", "<Esc>" },
    },
  },
  windows = { indent = 1 },
}

local icons = require "user.icons"

vim.fn.sign_define('DapBreakpoint', {text=icons.ui.Bug, texthl='DiagnosticSignError', linehl='', numhl=''})

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end

dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end

dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

-- Settings for nvim-dap-python:
local dap_python_status_ok, dap_python = pcall(require"dap-python")
if not dap_python_status_ok then
	return
end

-- NOTE: remember to pip install debugpy here vvv.
dap_python.setup('~/miniconda3/envs/neovim/bin/python')
table.insert(require('dap').configurations.python,
  {
    {
      name = "server",
      type = "python",
      request = "launch",
      module = "benchmarking_server.server"
    },
    {
      name = "Celery low",
      type = "python",
      request = "launch",
      module = "celery",
      args = {
        "-A",
        "benchmarking_server.app_definition.celery",
        "worker",
        "-E",
        "-n",
        "bms_low",
        "-Q",
        "bms_low",
        "-l",
        "INFO",
        "-c",
        "1",
        "--without-gossip",
        "--without-mingle",
        "--concurrency",
        "1",
        "--pool",
        "solo"
      }
    },
    {
      name = "Celery high",
      type = "python",
      request = "launch",
      module = "celery",
      args = {
        "-A",
        "benchmarking_server.app_definition.celery",
        "worker",
        "-B",
        "-E",
        "-n",
        "bms_high",
        "-Q",
        "bms_high",
        "-l",
        "INFO",
        "-c",
        "1",
        "--without-gossip",
        "--without-mingle",
        "--concurrency",
        "1",
        "--pool",
        "solo"
      }
    },
    {
      type = 'python',
      request = 'launch',
      name = 'My custom launch configuration',
      program = '${file}',
      -- ... more options, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings
    }})

-- See how to properly integrate these into whichkey:
-- nnoremap <silent> <leader>dn :lua require('dap-python').test_method()<CR>
-- nnoremap <silent> <leader>df :lua require('dap-python').test_class()<CR>
-- vnoremap <silent> <leader>ds <ESC>:lua require('dap-python').debug_selection()<CR>
