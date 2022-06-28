local dap_status_ok, dap = pcall(require, "dap")
if not dap_status_ok then
  vim.notify('Failed to require "dap"...')
  return
end

local dap_ui_status_ok, dapui = pcall(require, "dapui")
if not dap_ui_status_ok then
  vim.notify('Failed to require "dapui"...')
  return
end

local dap_python_status_ok, dap_python = pcall(require, "dap-python")
if not dap_python_status_ok then
  vim.notify('Failed to require "dap-python"...')
  return
end

local dap_virtual_text_status_ok, dap_virtual_text = pcall(require, "nvim-dap-virtual-text")
if not dap_virtual_text_status_ok then
  vim.notify('Failed to require "nvim-dap-virtual-text"...')
  return
end

local icons_status_ok, icons = pcall(require, "user.icons")
if not icons_status_ok then
  vim.notify('Failed to require "user.icons"...')
else
  vim.fn.sign_define('DapBreakpoint', {text=icons.ui.BigCircle, texthl='DiagnosticSignError', linehl='', numhl=''})
end

dap_virtual_text.setup({
  enabled = true,                        -- enable this plugin (the default)
  enabled_commands = true,               -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
  highlight_changed_variables = true,    -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
  highlight_new_as_changed = true,      -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
  show_stop_reason = true,               -- show stop reason when stopped for exceptions
  commented = true,                     -- prefix virtual text with comment string
  only_first_definition = true,          -- only show virtual text at first definition (if there are multiple)
  all_references = true,                -- show virtual text on all all references of the variable (not only definitions)
  filter_references_pattern = '<module', -- filter references (not definitions) pattern when all_references is activated (Lua gmatch pattern, default filters out Python modules)
  -- experimental features:
  virt_text_pos = 'eol',                 -- position of virtual text, see `:h nvim_buf_set_extmark()`
  -- virt_text_pos = 'right_align',                 -- position of virtual text, see `:h nvim_buf_set_extmark()`
  all_frames = true,                    -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
  virt_lines = false,                    -- show virtual lines instead of virtual text (will flicker!)
  virt_text_win_col = nil                -- position the virtual text at a fixed window column (starting from the first text column) ,
  -- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
})

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
  -- Expand lines larger than the window
  -- Requires >= 0.7
  expand_lines = vim.fn.has("nvim-0.7"),
  layouts = {
    {-- You can change the order of elements in the sidebar
      elements = {
        -- Provide as ID strings or tables with "id" and "size" keys
        { id = "scopes", },
        -- { id = "scopes", size = 0.25 }, -- Can be float or integer > 1
        -- { id = "breakpoints", size = 0.25 },
        -- { id = "stacks", size = 0.25 },
        { id = "watches", size = 0.25 },
      },
      size = 80,
      position = "right", -- Can be "left", "right", "top", "bottom"
    },
    {
      elements = { "repl", "console" },
      size = 20,
      position = "bottom", -- Can be "left", "right", "top", "bottom"
    },
  },
  floating = {
    max_height = 0.5, -- These can be integers or a float between 0 and 1.
    max_width = 0.9, -- Floats will be treated as percentage of your screen.
    border = "rounded", -- Border style. Can be "single", "double" or "rounded"
    mappings = {
      close = { "q", "<Esc>" },
    },
  },
  windows = { indent = 1 },
}

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end

dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end

dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

dap.adapters.python = {
  type = 'executable';
  -- command = '/Users/shacharlerer/miniconda3/envs/debugpy/bin/python';
  -- command = '/Users/shacharlerer/miniconda3/envs/neovim/bin/python';
  command = 'python3';
  args = { '-m', 'debugpy.adapter' };
}

dap.configurations.python = {
  {
    type = "python",
    request = "launch",
    name = "Launch file",
    justMyCode = false,
    program = "${file}",
    console = "integratedTerminal",
    pythonPath = require("user.utils").get_python_path(),
  },
  {
    type = "python",
    request = "launch",
    name = "Launch file with arguments",
    justMyCode = false,
    program = "${file}",
    args = function()
        local args_string = vim.fn.input('Arguments: ')
        return vim.split(args_string, " +")  -- split (greedy) the string on space
    end,
    console = "integratedTerminal",
    pythonPath = require("user.utils").get_python_path(),
  },
  {
    type = "python",
    request = "attach",
    name = "Attach remote",
    justMyCode = false,
    pythonPath = require("user.utils").get_python_path(),
    host = function()
      local value = vim.fn.input("Host [127.0.0.1]: ")
      if value ~= "" then
        return value
      end
      return "127.0.0.1"
    end,
    port = function()
      return tonumber(vim.fn.input("Port [5678]: ")) or 5678
    end,
  },
  {
    name = "BMS Server",
    type = "python",
    request = "launch",
    module = "benchmarking_server.server",
    justMyCode = false,
    pythonPath = require("user.utils").get_python_path(),
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
    },
    justMyCode = false,
    pythonPath = require("user.utils").get_python_path(),
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
    },
    justMyCode = false,
    pythonPath = require("user.utils").get_python_path(),
  },
}

dap_python.test_runner = 'pytest'
-- NOTE: remember to pip install debugpy here vvv.
-- dap_python.setup('/Users/shacharlerer/miniconda3/envs/neovim/bin/python', { include_configs = false })
dap_python.setup('python3', { include_configs = false })

dap.adapters.nlua = function(callback, config)
  callback({ type = "server", host = config.host, port = config.port })
end

dap.configurations.lua = {
  {
    type = "nlua",
    request = "attach",
    name = "Attach to running Neovim instance",
    host = function()
      local value = vim.fn.input("Host [127.0.0.1]: ")
      if value ~= "" then
        return value
      end
      return "127.0.0.1"
    end,
    port = function()
      local val = tonumber(vim.fn.input("Port: "))
      assert(val, "Please provide a port number")
      return val
    end,
  },
}

dap.adapters.lldb = {
  type = "executable",
  attach = { pidProperty = "pid", pidSelect = "ask" },
  command = "lldb-vscode",
  env = { LLDB_LAUNCH_FLAG_LAUNCH_IN_TTY = "YES" },
}

dap.configurations.rust = {
  {
    type = "rust",
    request = "launch",
    name = "lldb",
    program = function()
      local metadata_json = vim.fn.system("cargo metadata --format-version 1 --no-deps")
      local metadata = vim.fn.json_decode(metadata_json)
      local target_name = metadata.packages[1].targets[1].name
      local target_dir = metadata.target_directory
      return target_dir .. "/debug/" .. target_name
    end,
  },
}

dap.configurations.c = {
  {
    -- If you get an "Operation not permitted" error using this, try disabling YAMA:
    --  echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
    name = "Attach to process",
    type = "lldb", -- Adjust this to match your adapter name (`dap.adapters.<name>`)
    request = "attach",
    pid = require("dap.utils").pick_process,
    args = {},
  },
}

dap.configurations.cpp = {
  {
    -- If you get an "Operation not permitted" error using this, try disabling YAMA:
    --  echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
    name = "Attach to process",
    type = "lldb", -- Adjust this to match your adapter name (`dap.adapters.<name>`)
    request = "attach",
    pid = require("dap.utils").pick_process,
    args = {},
  },
}

-- ... more options, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings
-- See how to properly integrate these into whichkey:
-- nnoremap <silent> <leader>dn :lua require('dap-python').test_method()<CR>
-- nnoremap <silent> <leader>df :lua require('dap-python').test_class()<CR>
-- vnoremap <silent> <leader>ds <ESC>:lua require('dap-python').debug_selection()<CR>
