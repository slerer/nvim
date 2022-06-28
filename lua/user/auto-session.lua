do
  local status_ok, auto_session = pcall(require, "auto-session")
  if not status_ok then
  vim.notify('Failed to require "auto-session"...')
    return
  end

  local opts = {
    log_level = 'info',
    auto_session_enable_last_session = false, -- Loads the last loaded session if session for cwd does not exist
    auto_session_root_dir = vim.fn.stdpath('data').."/sessions/", -- Changes the root dir for sessions
    auto_session_enabled = true, -- Enables/disables the plugin's auto save and restore features
    auto_save_enabled = nil, -- Enables/disables auto saving
    auto_session_create_enabled = true, -- Enables/disables the plugin's session auto creation
    auto_restore_enabled = false, -- Enables/disables auto restoring
    auto_session_suppress_dirs = {'~/', '~/git/'}, -- Suppress session create/restore if in one of the list of dirs
    auto_session_use_git_branch = nil, -- Use the git branch to differentiate the session name
    auto_session_allowed_dirs = nil, -- Allow session create/restore if in one of the list of dirs
    -- the configs below are lua only
    bypass_session_save_file_types = nil -- Bypass session save if only buffer open is of one of these filetypes
  }
  auto_session.setup(opts)
end

-- vim.o.sessionoptions="blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"
vim.o.sessionoptions="blank,buffers,curdir,help,tabpages,winsize,winpos,terminal"

do
  local status_ok, session_lens = pcall(require, "session-lens")
  if not status_ok then
  vim.notify('Failed to require "session-lens"...')
    return
  end

  session_lens.setup({--[[your custom config--]]})
  -- session_lens.setup({
  --   previewer = true
  -- })
end
