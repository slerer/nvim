do
  local group = vim.api.nvim_create_augroup("my_general_stuff", { clear = true })

  vim.api.nvim_create_autocmd({ "User" }, {
    group = group,
    pattern = { "AlphaReady" },
    callback = function()
      vim.cmd [[
        set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2
      ]]
    end,
  })

  vim.api.nvim_create_autocmd({ "VimEnter" }, {
    group = group,
    callback = function()
      vim.cmd "hi link illuminatedWord LspReferenceText"
    end,
  })

  vim.api.nvim_create_autocmd({ "TextYankPost" }, {
    group = group,
    callback = function()
      vim.highlight.on_yank { higroup = "Visual", timeout = 200 }
    end,
  })
end

do
  local group = vim.api.nvim_create_augroup("my_filetype_stuff", { clear = true })

  vim.api.nvim_create_autocmd({ "FileType" }, {
    group = group,
    pattern = { "qf", "help", "man", "lspinfo", "spectre_panel" },
    callback = function()
      vim.cmd [[
        nnoremap <silent> <buffer> q :close<CR>
        set nobuflisted
      ]]
    end,
  })

  vim.api.nvim_create_autocmd({ "FileType" }, {
    group = group,
    pattern = { "gitcommit", "markdown" },
    callback = function()
      vim.cmd [[
        setlocal wrap
        setlocal spell
      ]]
    end,
  })

  vim.api.nvim_create_autocmd({ "FileType" }, {
    group = group,
    pattern = { "python" },
    callback = function()
      vim.cmd [[
        setlocal nowrap
        setlocal nospell
      ]]
    end,
  })
end

do
  local group = vim.api.nvim_create_augroup("my_buffers_stuff", { clear = true })

  vim.api.nvim_create_autocmd({ "BufEnter" }, {
    group = group,
    callback = function()
      vim.cmd [[
        if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif
      ]]
    end,
  })

  vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
    callback = function()
      vim.cmd "set formatoptions+=c" -- Auto-wrap comments using textwidth, inserting the current comment leader automatically.
      vim.cmd "set formatoptions+=r" -- Automatically insert the current comment leader after hitting <Enter> in Insert mode.
      vim.cmd "set formatoptions-=o" -- Do not automatically insert the current comment leader after hitting 'o' or 'O' in Normal mode.  In case comment is unwanted in a specific place use CTRL-U to quickly delete it.
      vim.cmd "set formatoptions+=1" -- Don't break a line after a one-letter word
      vim.cmd "set formatoptions+=n" -- Recognize numbered lists when formatting
      vim.cmd "set formatoptions-=t" -- Do not format just about any type of text, esp. source code
    end,
  })

  vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    pattern = { "*.java" },
    callback = function()
      vim.lsp.codelens.refresh()
    end,
  })

  -- Set/unset relative number when entering/exiting a buffer.
  vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave", "FocusGained" }, { command = "set relativenumber", group = group })
  vim.api.nvim_create_autocmd({ "BufLeave", "InsertEnter", "FocusLost" }, { command = "set norelativenumber", group = group })
end

do
  local group = vim.api.nvim_create_augroup("my_windows_stuff", { clear = true })

  -- Equalize windows on nvim's resize event
  -- vim.api.nvim_create_autocmd({ "VimResized" }, {
  --   group = group,
  --   callback = function()
  --     vim.cmd "tabdo wincmd ="
  --   end,
  -- })

  -- Kills the commands' editor in case you press 'q:' in normal mode. I don't think I like this.
  vim.api.nvim_create_autocmd({ "CmdWinEnter" }, {
    group = group,
    callback = function()
      vim.cmd "quit"
    end,
  })
end

do
  local group = vim.api.nvim_create_augroup("set_omnifunc", { clear = true })
  vim.api.nvim_create_autocmd({ "FileType" }, {
    group = group,
    pattern = { "python", "lua", "markdown", "sh" },
    callback = function()
      vim.cmd [[
        setlocal omnifunc=v:lua.vim.lsp.omnifunc
      ]]
    end,
  })
end
