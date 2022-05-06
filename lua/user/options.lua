local options = {
  backup = false,                          -- creates a backup file
  swapfile = false,                        -- creates a swapfile
  fileencoding = "utf-8",                  -- the encoding written to a file
  undofile = true,                         -- enable persistent undo
  writebackup = false,                     -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
  autoread = true,                         -- Auto-reload buffers when file changed on disk
  clipboard = "unnamedplus",               -- allows neovim to access the system clipboard
  mouse = "a",                             -- allow the mouse to be used in neovim
  mousehide = true,                        -- hide mouse pointer when typing
  cmdheight = 2,                           -- more space in the neovim command line for displaying messages
  -- colorcolumn = "80",
  guifont = "Menlo:h18",                   -- the font used in graphical neovim applications
  termguicolors = true,                    -- set term gui colors (most terminals support this)
  colorcolumn = "120",
  scrolloff = 8,                           -- is one of my fav
  sidescroll = 1,                          -- brings characters in view when side scrolling.
  sidescrolloff = 8,                       -- start side-scrolling when n chars are left. Old config value was 26
  pumheight = 10,                          -- pop up menu height
  showmode = false,                        -- we don't need to see things like -- INSERT -- anymore
  showtabline = 2,                         -- always show tabs
  cursorline = true,                       -- highlight the current line
  numberwidth = 4,                         -- set number column width to 2 {default 4}
  laststatus = 3,
  signcolumn = "yes",                      -- always show the sign column, otherwise it would shift the text each time
  number = true,                           -- set numbered lines
  relativenumber = true,                   -- set relative numbered lines
  completeopt = { "menuone", "noselect" }, -- mostly just for cmp
  conceallevel = 0,                        -- so that `` is visible in markdown files
  hlsearch = true,                         -- highlight all matches on previous search pattern
  ignorecase = true,                       -- ignore case in search patterns
  smartcase = true,                        -- smart case
  infercase = true,
  autoindent = true,                       -- indent when moving to the next line while writing code
  smartindent = true,                      -- make indenting smarter again
  splitbelow = true,                       -- force all horizontal splits to go below current window
  splitright = true,                       -- force all vertical splits to go to the right of current window
  timeoutlen = 750,                        -- time to wait for a mapped sequence to complete (in milliseconds - was 100)
  ttimeoutlen = 150,
  updatetime = 300,                        -- faster completion (4000ms default)
  expandtab = true,                        -- convert tabs to spaces
  shiftwidth = 2,                          -- the number of spaces inserted for each indentation (was 4)
  shiftround = true,
  tabstop = 2,                             -- insert 2 spaces for a tab (was 4)
  softtabstop = 2,                         -- when <BS>, pretend tab is removed, even if spaces (was 4)
  smarttab = true,                         -- insert tabs on the start of a line according to shiftwidth, not tabstop
  wrap = false,                            -- display lines as one long line
  linebreak = true,                        -- break long lines at words, when wrap is on
  showbreak = "↪",                         -- string to put at the starting of wrapped lines
  list = true,                             -- show invisible characters like spaces enabled later via autocmd on certain filetypes
  pastetoggle = "<F2>",

}
vim.g.python3_host_prog = "/Users/slerer/opt/anaconda3/envs/neovim/bin/python3"

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.fillchars.eob=" "

-- new method using lua API:
vim.opt.shortmess:append "c"
-- executing via vim.cmd:
vim.cmd [[set formatoptions-=t]] -- do not format just about any type of text, esp. source code
vim.cmd [[set formatoptions+=n]] -- recognize numbered lists when formatting
vim.cmd [[set formatoptions+=1]] -- don't break a line after a one-letter word

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.cmd "set whichwrap+=<,>,[,],h,l"
vim.cmd "set nojoinspaces" -- prevents two spaces after punctuation on join
vim.cmd "set nofsync" -- allows OS to decide when to flush to disk
vim.cmd [[ set listchars=tab:▸\ ,trail:·,extends:❯,precedes:❮,nbsp:· ]]
vim.cmd [[set iskeyword+=-]]

-- Adding the next two in case I'll reinstall FZF
if vim.fn.executable('rg') == 1 then
    vim.g.rg_derive_root = 'true'
end

if vim.fn.executable('ag') == 1 then
    vim.o.grepprg = "ag --nogroup --nocolor"
end

vim.g.undotree_SetFocusWhenToggle = 1
vim.g.undotree_SplitWidth = 40
vim.g.undotree_WindowLayout = 2

vim.g.vista_fzf_preview = 'right:50%'
vim.g.vista_echo_cursor_strategy = 'both'
vim.g.vista_sidebar_width = 40
