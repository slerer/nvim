local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then
  vim.notify('Failed to require "toggleterm"...')
	return
end

toggleterm.setup({
	size = 20,
	open_mapping = [[<c-\>]],
	hide_numbers = true,
	shade_filetypes = {},
	shade_terminals = true,
	shading_factor = 2,
	start_in_insert = true,
	insert_mappings = true,
	persist_size = true,
	direction = "float",
	close_on_exit = true,
	shell = vim.o.shell,
	float_opts = {
		border = "curved",
		winblend = 0,
		highlights = {
			border = "Normal",
			background = "Normal",
		},
	},
})

function _G.set_terminal_keymaps()
  local opts = {noremap = true}
  -- vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', 'jkjk', [[<C-\><C-n>]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-h>', [[<C-\><C-n><C-W>h]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-j>', [[<C-\><C-n><C-W>j]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-l>', [[<C-\><C-n><C-W>l]], opts)
end

do
  local group = vim.api.nvim_create_augroup("toggleterm", { clear = true })

  vim.api.nvim_create_autocmd({ "TermOpen" }, {
    group = group,
    -- pattern = { "term://*" },
    command = "lua set_terminal_keymaps()"
  })
end

local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })

function _LAZYGIT_TOGGLE()
	lazygit:toggle()
end

-- local node = Terminal:new({ cmd = "node", hidden = true })
--
-- function _NODE_TOGGLE()
-- 	node:toggle()
-- end
--
-- local ncdu = Terminal:new({ cmd = "ncdu", hidden = true })
--
-- function _NCDU_TOGGLE()
-- 	ncdu:toggle()
-- end

local htop = Terminal:new({ cmd = "htop", hidden = true })

function _HTOP_TOGGLE()
	htop:toggle()
end

local python = Terminal:new({ cmd = "python", hidden = true })

function _PYTHON_TOGGLE()
	python:toggle()
end

local ipython = Terminal:new({ cmd = "ipython", hidden = true })

function _IPYTHON_TOGGLE()
	ipython:toggle()
end

-- Trying this for integration with "kwkarlwang/bufresize.nvim"
-- TODO: Still need to think of how to hijack the mapping in better way so WIP.
do
  local opts = { noremap = true, silent = true }
  local map = vim.api.nvim_set_keymap

  ToggleTerm = function(direction)
      local command = "ToggleTerm"
      if direction == "horizontal" then
          command = command .. " direction=horizontal"
      elseif direction == "vertical" then
          command = command .. " direction=vertical"
      end
      if vim.bo.filetype == "toggleterm" then
          require("bufresize").block_register()
          vim.api.nvim_command(command)
          require("bufresize").resize_close()
      else
          require("bufresize").block_register()
          vim.api.nvim_command(command)
          require("bufresize").resize_open()
          vim.cmd([[execute "normal! i"]])
      end
  end
  -- map("n", "<C-s>", ":lua ToggleTerm()<cr>", opts)
  -- map("n", "<leader>ot", [[:lua ToggleTerm("horizontal")<cr>]], opts)
  -- map("n", "<leader>ol", [[:lua ToggleTerm("vertical")<cr>]], opts)
  -- map("i", "<C-s>", "<esc>:lua ToggleTerm()<cr>", opts)
  -- map("t", "<C-s>", "<C-\\><C-n>:lua ToggleTerm()<cr>", opts)

  -- map( "t", "<leader>wd",
  --   "<C-\\><C-n>"
  --     .. ":lua require('bufresize').block_register()<cr>"
  --     .. "<C-w>c"
  --     .. ":lua require('bufresize').resize_close()<cr>",
  --   opts
  -- )

  map( "n", "<leader>wd",
    ":lua require('bufresize').block_register()<cr>" .. "<C-w>c" .. ":lua require('bufresize').resize_close()<cr>",
    opts
  )
end
