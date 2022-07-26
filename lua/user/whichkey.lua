local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  vim.notify('Failed to require "which-key"...')
  return
end

local setup = {
  plugins = {
    marks = true, -- shows a list of your marks on ' and `
    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    spelling = {
      enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20, -- how many suggestions should be shown in the list?
    },
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    presets = {
      operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
      motions = true, -- adds help for motions
      text_objects = true, -- help for text objects triggered after entering an operator
      windows = true, -- default bindings on <c-w>
      nav = true, -- misc bindings to work with windows
      z = true, -- bindings for folds, spelling and others prefixed with z
      -- g = true, -- bindings for prefixed with g
    },
  },
  -- add operators that will trigger motion and text object completion
  -- to enable all native operators, set the preset / operators plugin above
  -- operators = { gc = "Comments" },
  key_labels = {
    -- override the label used to display some keys. It doesn't effect WK in any other way.
    -- For example:
    -- ["<space>"] = "SPC",
    -- ["<cr>"] = "RET",
    -- ["<tab>"] = "TAB",
  },
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "➜", -- symbol used between a key and it's label
    group = "+", -- symbol prepended to a group
  },
  popup_mappings = {
    scroll_down = "<c-d>", -- binding to scroll down inside the popup
    scroll_up = "<c-u>", -- binding to scroll up inside the popup
  },
  window = {
    border = "rounded", -- none, single, double, shadow
    position = "bottom", -- bottom, top
    margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
    padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
    winblend = 0,
  },
  layout = {
    height = { min = 4, max = 25 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 3, -- spacing between columns
    align = "center", -- align columns left, center or right
  },
  -- ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
  ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
  hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
  show_help = true, -- show help message on the command line when the popup is visible
  -- triggers = "auto", -- automatically setup triggers
  -- triggers = {"<leader>"} -- or specify a list manually
  triggers_blacklist = {
    -- list of mode / prefixes that should never be hooked by WhichKey
    -- this is mostly relevant for key maps that start with a native binding
    -- most people should not need to change this
    i = { "j", "k" },
    v = { "j", "k" },
  },
}

local opts = {
  mode = "n", -- NORMAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

local vopts = {
  mode = "v", -- VISUAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps

}
local m_opts = {
  mode = "n", -- NORMAL mode
  prefix = "m",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

-- mappings for NORMAL mode starting with <leader>
local mappings = {
  ["a"] = { "<cmd>Alpha<cr>", "Alpha" },

  b = {
    name = "Buffers",
    -- d = { "<cmd>Bdelete!<CR>", "Delete buffer" },
    d = { "<cmd>Bwipeout<CR>", "Delete buffer" },
    f = { "<cmd>Telescope buffers theme=ivy<cr>", "Buffers" },
  },

  d = {
    name = "Debug",
    b = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Breakpoint" },
    c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
    i = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" },
    o = { "<cmd>lua require'dap'.step_over()<cr>", "Step Over" },
    O = { "<cmd>lua require'dap'.step_out()<cr>", "Step Out" },
    r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Toggle Repl" },
    s = { "<cmd>lua require'dap-python'.debug_selection()<cr>", "Debug Selection" },
    l = { "<cmd>lua require'dap'.run_last()<cr>", "Run last" },
    p = { "<cmd>lua require'dap'.pause()<cr>", "Pause thread" },
    t = { "<cmd>lua require'dap'.terminate()<cr>", "Terminate" },
    x = { "<cmd>lua require'dap'.terminate()<cr>", "Terminate" },
    e = { "<cmd>lua require'dapui'.eval()<cr>", "Eval" },
    u = { "<cmd>lua require'dapui'.toggle()<cr>", "Toggle UI" },
    S = { "<cmd>lua require'dapui'.float_element('scopes')<cr>", "Float Scopes" },
    R = { "<cmd>lua require'dapui'.float_element('repl')<cr>", "Float REPL" },
    C = { "<cmd>lua require'dapui'.float_element('console')<cr>", "Float Console" },
    W = { "<cmd>lua require'dapui'.float_element('watches')<cr>", "Float Watches" },
    B = { "<cmd>lua require'dapui'.float_element('breakpoints')<cr>", "Float Breakpoints" },
    F = { "<cmd>lua require'dapui'.float_element()<cr>", "Open Float" },
  },

  -- ["e"] = { "<cmd>NvimTreeToggle<cr>", "Project Tree" },
  -- ["e"] = { "<cmd>NvimTreeFocus<cr>", "Project Tree" },
  ["e"] = { "<cmd>NvimTreeFindFileToggle<cr>", "Project Tree" },
  -- nnoremap <silent> <leader>B :lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
  -- nnoremap <silent> <leader>lp :lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>

  f = {
    name = "Find",
    b = { "<cmd>Telescope buffers theme=ivy<cr>", "Buffers" },
    B = { "<cmd>Telescope file_browser theme=ivy<cr>", "File Browser" },
    c = { "<cmd>Telescope commands<cr>", "Commands" },
    C = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
    f = { "<cmd>lua require('telescope.builtin').find_files()<cr>", "Find files in CWD" },
    s = { "<cmd>Telescope grep_string theme=ivy<cr>", "Grep word under cursor" },
    g = { "<cmd>Telescope live_grep theme=ivy<cr>", "Live Grep" },
    G = { "<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args() theme=ivy<cr>", "Live Grep Args" },
    h = { "<cmd>Telescope help_tags<cr>", "Help" },
    l = { "<cmd>Telescope resume<cr>", "Last Search" },
    -- m = { "<cmd>lua require('telescope').extensions.media_files.media_files()<cr>", "Media" },
    m = { "<cmd>lua require('telescope').marks<cr>", "Marks" },
    M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
    r = { "<cmd>Telescope oldfiles<cr>", "Old Files" },
    R = { "<cmd>Telescope registers<cr>", "Registers" },
    k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
    t = { "<cmd>lua require('user.utils').open_trove_url({line=vim.api.nvim_get_current_line()})<cr>", "Open trove:// url"}
  },

  g = {
    name = "+Git",
    g = { "<cmd>lua _LAZYGIT_TOGGLE()<CR>", "Lazygit" },
    j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
    k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
    l = { "<cmd>GitBlameToggle<cr>", "Blame" },
    p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
    r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
    R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
    s = { "<cmd>Git<CR>", "Status" },
    S = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
    U = { "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", "Undo Stage Hunk" },
    o = { "<cmd>Telescope git_status<cr>", "Open changed files" },
    b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
    d = { "<cmd>Gitsigns diffthis HEAD<cr>", "Diff" },
    G = { name = "+Gist",
      a = { "<cmd>Gist -b -a<cr>", "Create Anon" },
      d = { "<cmd>Gist -d<cr>", "Delete" },
      f = { "<cmd>Gist -f<cr>", "Fork" },
      g = { "<cmd>Gist -b<cr>", "Create" },
      l = { "<cmd>Gist -l<cr>", "List" },
      p = { "<cmd>Gist -b -p<cr>", "Create Private" },
    },
    C = { name = "+Conflict",
      o = { "<cmd>ConflictMarkerOurselves<cr>", "" },
      t = { "<cmd>ConflictMarkerThemselves<cr>", "" },
      b = { "<cmd>ConflictMarkerBoth<cr>", "" },
    },
    h = {
      name = "+Github",
      c = {
        name = "+Commits",
        c = { "<cmd>GHCloseCommit<cr>", "Close" },
        e = { "<cmd>GHExpandCommit<cr>", "Expand" },
        o = { "<cmd>GHOpenToCommit<cr>", "Open To" },
        p = { "<cmd>GHPopOutCommit<cr>", "Pop Out" },
        z = { "<cmd>GHCollapseCommit<cr>", "Collapse" },
      },
      i = {
        name = "+Issues",
        p = { "<cmd>GHPreviewIssue<cr>", "Preview" },
      },
      l = {
        name = "+Litee",
        t = { "<cmd>LTPanel<cr>", "Toggle Panel" },
      },
      r = {
        name = "+Review",
        b = { "<cmd>GHStartReview<cr>", "Begin" },
        c = { "<cmd>GHCloseReview<cr>", "Close" },
        d = { "<cmd>GHDeleteReview<cr>", "Delete" },
        e = { "<cmd>GHExpandReview<cr>", "Expand" },
        s = { "<cmd>GHSubmitReview<cr>", "Submit" },
        z = { "<cmd>GHCollapseReview<cr>", "Collapse" },
      },
      p = {
        name = "+Pull Request",
        c = { "<cmd>GHClosePR<cr>", "Close" },
        d = { "<cmd>GHPRDetails<cr>", "Details" },
        e = { "<cmd>GHExpandPR<cr>", "Expand" },
        o = { "<cmd>GHOpenPR<cr>", "Open" },
        p = { "<cmd>GHPopOutPR<cr>", "PopOut" },
        r = { "<cmd>GHRefreshPR<cr>", "Refresh" },
        t = { "<cmd>GHOpenToPR<cr>", "Open To" },
        z = { "<cmd>GHCollapsePR<cr>", "Collapse" },
      },
      t = {
        name = "+Threads",
        c = { "<cmd>GHCreateThread<cr>", "Create" },
        n = { "<cmd>GHNextThread<cr>", "Next" },
        t = { "<cmd>GHToggleThread<cr>", "Toggle" },
      },
    },
  },

  -- ["gy"] = "Link",

  -- ["h"] = { "<cmd>HopWord<CR>", "Hop word" },
  -- ["/"] = { "<cmd>HopPattern<CR>", "Hop /" },
  -- Trying the multi-window variants that were introduced lately:
  ["h"] = { "<cmd>HopWordMW<CR>", "Hop word" },
  ["/"] = { "<cmd>HopPatternMW<CR>", "Hop /" },

  l = {
    name = "LSP",
    a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
    d = { "<cmd>TroubleToggle document_diagnostics<cr>", "Diagnostics" },
    w = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "Workspace Diagnostics" },
    f = { "<cmd>lua vim.lsp.buf.format({ async = true })<cr>", "Format" },
    F = { "<cmd>LspToggleAutoFormat<cr>", "Toggle Autoformat" },
    fr = { "<cmd>luafile %<cr>", "luafile %" },
    i = { "<cmd>LspInfo<cr>", "Info" },
    I = { "<cmd>LspInstallInfo<cr>", "Installer Info" },
    j = { "<cmd>lua vim.diagnostic.goto_next({buffer=0})<CR>", "Next Diagnostic" },
    k = { "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>", "Prev Diagnostic" },
    -- l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
    o = { "<cmd>SymbolsOutline<cr>", "Outline Symbols" },
    t = { "<cmd>AerialToggle<cr>", "Aerial Tree" },
    -- Maybe I should change vvv to quickfix? Still need to see which one I'm using more...
    q = { "<cmd>lua vim.diagnostic.setloclist()<cr>", "Quickfix (BQF)" },
    Q = { "<cmd>TroubleToggle loclist<cr>", "Locklist (Trouble)" },
    r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename (LSP)" },
    R = { "<cmd>TroubleToggle lsp_references<cr>", "References" },
    s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
    S = { "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", "Workspace Symbols" },
  },

  n = {
    name = "Neotest",
    a = { '<cmd>lua require("neotest").run.attach()<cr>', "Attach to the nearest test" },
    d = { '<cmd>lua require("neotest").run.run({strategy = "dap"})<cr>', "Debug the nearest test" },
    r = { '<cmd>lua require("neotest").run.run()<cr>', "Run the nearest test" },
    f = { '<cmd>lua require("neotest").run.run(vim.fn.expand("%"))<cr>', "Run the current file" },
    o = { '<cmd>lua require("neotest").output.open({short = true})<cr>', "open float with tests' output" },
    O = { '<cmd>lua require("neotest").output.open()<cr>', "open float with single test' output" },
    -- o = { '<cmd>lua require("neotest").output.open({enter = true, short = true})<cr>', "open float with tests' output" },
    -- O = { '<cmd>lua require("neotest").output.open({enter = true})<cr>', "open float with single test' output" },
    s = { '<cmd>lua require("neotest").run.stop()<cr>', "Stop the nearest test" },
    t = { '<cmd>lua require("neotest").summary.toggle()<cr>', "Toggle Summary" },
  },

  o = {
    name = "Options",
    p = { '<cmd>lua require("user.utils").toggle_option("paste")<cr>', "Toggle paste" },
    w = { '<cmd>lua require("user.utils").toggle_option("wrap")<cr>', "Toggle wrap" },
    r = { '<cmd>lua require("user.utils").toggle_option("relativenumber")<cr>', "Toggle relativenumber" },
    c = { '<cmd>lua require("user.utils").toggle_option("cursorcolumn")<cr>', "Toggle cursorcolumn" },
    l = { '<cmd>lua require("user.utils").toggle_option("cursorline")<cr>', "Toggle cursorline" },
    s = { '<cmd>lua require("user.utils").toggle_option("spell")<cr>', "Toggle spell" },
    S = { '<cmd>lua require("user.utils").toggle_option("wrapscan")<cr>', "Toggle wrapscan" },
  },

  p = {
    name = "Packer",
    c = { "<cmd>PackerCompile<cr>", "Compile" },
    C = { "<cmd>PackerClean<cr>", "Clean" },
    i = { "<cmd>PackerInstall<cr>", "Install" },
    s = { "<cmd>PackerSync<cr>", "Sync" },
    S = { "<cmd>PackerStatus<cr>", "Status" },
    u = { "<cmd>PackerUpdate<cr>", "Update" },
  },

  ["P"] = { "<cmd>lua require('telescope').extensions.projects.projects()<cr>", "Projects" },

  r = {
    name = "Replace",
    n = { "<cmd>lua require('nvim-treesitter-refactor.smart_rename').smart_rename()<cr>", "Rename (treesitter-refactor)" },
    -- r = { "<cmd>lua require('spectre').open()<cr>", "Replace" },
    w = { "<cmd>lua require('spectre').open_visual({select_word=true})<cr>", "Replace Word" },
    f = { "<cmd>lua require('spectre').open_file_search()<cr>", "Replace Buffer" },
  },

  -- s = {
  --   name = "Surround",
  --   ["."] = { "<cmd>lua require('surround').repeat_last()<cr>", "Repeat" },
  --   a = { "<cmd>lua require('surround').surround_add(true)<cr>", "Add" },
  --   d = { "<cmd>lua require('surround').surround_delete()<cr>", "Delete" },
  --   r = { "<cmd>lua require('surround').surround_replace()<cr>", "Replace" },
  --   q = { "<cmd>lua require('surround').toggle_quotes()<cr>", "Quotes" },
  --   b = { "<cmd>lua require('surround').toggle_brackets()<cr>", "Brackets" },
  -- },

  S = {
    -- name = "Session",
    -- s = { "<cmd>SaveSession<cr>", "Save" },
    -- l = { "<cmd>LoadLastSession!<cr>", "Load Last" },
    -- d = { "<cmd>LoadCurrentDirSession!<cr>", "Load Last Dir" },
    -- f = { "<cmd>Telescope sessions save_current=false<cr>", "Find Session" },
    name = "SnipRun",
    c = { "<cmd>SnipClose<cr>", "Close" },
    f = { "<cmd>%SnipRun<cr>", "Run File" },
    i = { "<cmd>SnipInfo<cr>", "Info" },
    m = { "<cmd>SnipReplMemoryClean<cr>", "Mem Clean" },
    r = { "<cmd>SnipReset<cr>", "Reset" },
    t = { "<cmd>SnipRunToggle<cr>", "Toggle" },
    x = { "<cmd>SnipTerminate<cr>", "Terminate" },
  },

  t = {
    name = "Terminal",
    ["1"] = { ":1ToggleTerm<cr>", "1" },
    ["2"] = { ":2ToggleTerm<cr>", "2" },
    ["3"] = { ":3ToggleTerm<cr>", "3" },
    ["4"] = { ":4ToggleTerm<cr>", "4" },
    n = { "<cmd>lua _NODE_TOGGLE()<cr>", "Node" },
    u = { "<cmd>lua _NCDU_TOGGLE()<cr>", "NCDU" },
    t = { "<cmd>lua _HTOP_TOGGLE()<cr>", "Htop" },
    p = { "<cmd>lua _PYTHON_TOGGLE()<cr>", "Python" },
    f = { "<cmd>ToggleTerm direction=float<cr>", "Float" },
    h = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal" },
    v = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "Vertical" },
  },

  T = {
    name = "Treesitter",
    h = { "<cmd>TSHighlightCapturesUnderCursor<cr>", "Highlight" },
    p = { "<cmd>TSPlaygroundToggle<cr>", "Playground" },
  },

  -- Vista stuff
  v = {
    name = "Vista",
    c = { "<cmd>Vista!<cr>", "Close Vista window" },
    t = { "<cmd>Vista!!<cr>", "Toggle Vista window" },
    f = { "<cmd>Vista focus<cr>", "Toggle focus" },
  },

  ["z"] = { "<cmd>ZenMode<cr>", "Zen" },
}

-- mappings for VISUAL mode starting with <leader>
local vmappings = {
  ["/"] = { '<ESC><CMD>lua require("Comment.api").toggle_linewise_op(vim.fn.visualmode())<CR>', "Comment" },
  s = { "<esc><cmd>'<,'>SnipRun<cr>", "Run range" },
  e = { "<cmd>lua require('dapui').eval()<cr>", "Eval selection" },
  -- d = { "<esc><cmd>lua require('dap-python').debug_selection()<cr>", "Debug range" },
}

-- general mappings for "Marks" of all sorts in NORMAL mode starting with 'm' (no <leader>).
local m_mappings = {
  a = { "<cmd>BookmarkAnnotate<cr>", "Add Annotated Bookmark" },
  m = { "<cmd>BookmarkToggle<cr>", "Toggle Bookmark" },
  j = { "<cmd>BookmarkNext<cr>", "Next Bookmark" },
  k = { "<cmd>BookmarkPrev<cr>", "Prev Bookmark" },
  S = { "<cmd>lua require('telescope').extensions.vim_bookmarks.all({ hide_filename=false, prompt_title=\"bookmarks\", shorten_path=false })<cr>",
    "Show All Bookmarks",
  },
  s = { "<cmd>lua require('telescope').extensions.vim_bookmarks.current_file()<cr>", "Show Bookmarks in buffer", },
  x = { "<cmd>BookmarkClearAll<cr>", "Clear All Bookmarks" },
  -- Harpoon
  h = { '<cmd>lua require("harpoon.mark").add_file()<cr>', "Add to Harpoon" },
  u = { '<cmd>lua require("harpoon.ui").toggle_quick_menu()<cr>', "Show Harpoon Menu" },
  n = { '<cmd>lua require("harpoon.ui").nav_next()<cr>', "Next harpooned file" },
  p = { '<cmd>lua require("harpoon.ui").nav_prev()<cr>', "Previous harpooned file" },
  c = { "<cmd>lua require('harpoon.cmd-ui').toggle_quick_menu()<cr>", "Harpooned commands" },
  -- NOTE: testing these, there are many more options. Trying to create REPL/testing-automation
  t = {
    g1 = { '<cmd>lua require("harpoon.tmux").gotoTerminal(1)<cr>', 'Goto Term1' },
    g2 = { '<cmd>lua require("harpoon.tmux").gotoTerminal(2)<cr>', 'Goto Term2' },
    g3 = { '<cmd>lua require("harpoon.tmux").gotoTerminal(3)<cr>', 'Goto Term3' },
    g4 = { '<cmd>lua require("harpoon.tmux").gotoTerminal(4)<cr>', 'Goto Term4' },
    gr = { '<cmd>lua require("harpoon.tmux").gotoTerminal("{right-of}")<cr>', 'Goto Term on the right' },
  },
}

vim.keymap.set("n", "<leader>rr", function() return ":IncRename " .. vim.fn.expand("<cword>") end, { expr = true , desc = 'Incremental Rename'})
which_key.setup(setup)
which_key.register(mappings, opts)
which_key.register(vmappings, vopts)
which_key.register(m_mappings, m_opts)
