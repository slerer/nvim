local opts = { noremap = true, silent = true }
local opts_nowait = { noremap = true, silent = true, nowait = true }
local term_opts = { silent = true }

-- Shorten function name
-- local keymap = vim.keymap.set

--Remap space as leader key
-- vim.keymap.set("", "<Space>", "<Nop>")
vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Remap 's' to NOP to avoid accidents during sandwich operations
vim.keymap.set("n", "s", "<NOP>", opts)
-- Remap j and k to act as expected when used on long, wrapped, lines
vim.keymap.set("n", "j", "gj", opts)
vim.keymap.set("n", "k", "gk", opts)
-- Same for <Down> and <Up>
vim.keymap.set("n", "<Down>", "gj", opts)
vim.keymap.set("n", "<Up>", "gk", opts)
vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>", opts)
-- jump to the next item, skipping the groups
vim.keymap.set("n", "]t", "<cmd>lua require('trouble').next({skip_groups = true, jump = true})<cr>", opts)
-- jump to the previous item, skipping the groups
vim.keymap.set("n", "[t", "<cmd>lua require('trouble').previous({skip_groups = true, jump = true})<cr>", opts)

-- Better window navigation
-- vim.keymap.set("n", "<C-h>", "<C-w>h", opts)
-- vim.keymap.set("n", "<C-j>", "<C-w>j", opts)
-- vim.keymap.set("n", "<C-k>", "<C-w>k", opts)
-- vim.keymap.set("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
-- vim.keymap.set("n", "<C-Up>", ":resize -2<CR>", opts)
-- vim.keymap.set("n", "<C-Down>", ":resize +2<CR>", opts)
-- vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", opts)
-- vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Naviagate buffers
vim.keymap.set("n", "<S-l>", ":bnext<CR>", opts)
vim.keymap.set("n", "<S-h>", ":bprevious<CR>", opts)

-- Move text up and down
-- TODO: Currently Alt or Meta key does not work for my setup with Alacritty...
vim.keymap.set("n", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
vim.keymap.set("n", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)

-- Insert --
-- Press jk fast to enter
-- vim.keymap.set("i", "jk", "<ESC>", opts)
vim.keymap.set("i", "<C-c>", "<ESC>", opts)
vim.keymap.set("i", "<C-e>", "<end>", opts)
vim.keymap.set("i", "<C-a>", "<home>", opts)
vim.keymap.set("i", "<C-u>", "<C-g>u<C-u>", opts)
vim.keymap.set("i", "<C-r>", "<C-g>u<C-r>", opts)

-- Visual --
-- Stay in indent mode
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-- Move text up and down
vim.keymap.set("v", "J", ":move '>+1<CR>gv-gv", opts)
vim.keymap.set("v", "K", ":move '<-2<CR>gv-gv", opts)
-- vim.keymap.set("v", "<A-j>", ":m .+1<CR>==", opts)
-- vim.keymap.set("v", "<A-k>", ":m .-2<CR>==", opts)
-- vim.keymap.set("v", "<M-j>", ":m .+1<CR>==", opts)
-- vim.keymap.set("v", "<M-k>", ":m .-2<CR>==", opts)

-- pasting without overwriting "register
-- vim.keymap.set("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
vim.keymap.set("x", "J", ":move '>+1<CR>gv-gv", opts)
vim.keymap.set("x", "K", ":move '<-2<CR>gv-gv", opts)
-- vim.keymap.set("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
-- vim.keymap.set("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Terminal --
-- Better terminal navigation
vim.keymap.set("t", "<C-o>", "<C-\\><C-N>", term_opts, opts)
-- vim.keymap.set("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts, opts)
-- vim.keymap.set("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts, opts)
-- vim.keymap.set("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts, opts)
-- vim.keymap.set("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts, opts)

-- Custom
vim.keymap.set("n", "<esc><esc>", "<cmd>nohlsearch<cr>", opts)
-- vim.keymap.set("n", "<C-/>", "<cmd>nohlsearch<cr>", opts)
vim.keymap.set("n", "<F1>", ":e ~/.my_notes/<cr>", opts)
vim.keymap.set("n", "<F3>", "<cmd>Telescope resume<cr>", opts)
vim.keymap.set("n", "<F4>", ":UndotreeToggle<cr>", opts)
vim.keymap.set("n", "<leader>u", ":UndotreeToggle<cr>", opts)
vim.keymap.set("n", "<F5>", "<cmd>Telescope commands<CR>", opts)
-- vim.keymap.set( "n", "<F6>",
--   [[:echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">" . " FG:" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"fg#")<CR>]],
--   opts
-- )
-- vim.keymap.set("n", "<F7>", "<cmd>TSHighlightCapturesUnderCursor<cr>", opts)
vim.keymap.set("n", "<F8>", ":Vista!!<CR>", opts)
vim.keymap.set("n", "<space><space>", ":Vista finder<CR>", opts)
-- vim.keymap.set("n", "<F11>", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
-- vim.keymap.set("n", "<F12>", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
vim.keymap.set("v", "//", [[y/\V<C-R>=escape(@",'/\')<CR><CR>]], opts)
-- vim.keymap.set(
--   "n",
--   "<C-p>",
--   "<cmd>lua require('telescope.builtin').git_files(require('telescope.themes').get_dropdown{previewer = false})<cr>",
--   opts
-- )
vim.keymap.set( "n", "<C-p>", "<cmd>lua require('telescope.builtin').git_files()<cr>", opts)
vim.keymap.set("n",
               "<leader><leader>",
               "<Cmd>lua require('telescope').extensions.frecency.frecency()<CR>",
               { desc = 'Find (F)Recent Files', silent = true })
vim.keymap.set("n", "<C-t>", "<cmd>lua vim.lsp.buf.document_symbol()<cr>", opts)
vim.keymap.set("n", "<c-n>", ":e ~/.my_notes/<cr>", opts)

vim.keymap.set("n", "-", ":lua require'lir.float'.toggle()<cr>", { desc = 'Toggle File Browser (lir)', silent = true })
-- vim.keymap.set("n", "gx", [[:silent execute '!$BROWSER ' . shellescape(expand('<cfile>'), 1)<CR>]], opts)
-- Change '<CR>' to whatever shortcut you like :)
vim.keymap.set("n", "<CR>", ":up|noh<CR>", opts_nowait)
vim.keymap.set("n", "<C-w>z", "<cmd>NeoZoomToggle<CR>", opts_nowait)
vim.keymap.set("n", "<BS>", "<Plug>(choosewin)", opts)
-- vim.keymap.set(
--   "n",
--   "=",
--   "<cmd>JABSOpen<cr>",
--   { noremap = true, silent = true, nowait = true }
-- )

vim.keymap.set("n", "<leader>json", ":%!python -m json.tool<CR>") -- Formatting a JSON fil, optse
vim.keymap.set("n", "<C-j>", "i<CR><ESC>") -- Formatting a JSON fil, optse
vim.keymap.set("n",  "<C-h>", "<cmd>SidewaysLeft<CR>", opts)
vim.keymap.set("n",  "<C-l>", "<cmd>SidewaysRight<CR>", opts)
-- vim.keymap.set("n", "<leader>spell", ":set spell!<CR>", opts)
-- vim.keymap.set("n", "<leader>wrap", ":set wrap!<CR>", opts)
-- Try and prevent annoying stuff from being too-slow in depressing `Shift``
vim.keymap.set("n",  ":Q", ":q", opts)
vim.keymap.set("n",  ":W", ":w", opts)
vim.keymap.set("n",  ":X", ":x", opts)
vim.keymap.set("n",  ":B", ":b", opts)
vim.keymap.set("n",  ":Bn", ":bn", opts)
vim.keymap.set("n",  ":Bp", ":bp", opts)
vim.keymap.set("n",  ":Cn", ":cn", opts)
vim.keymap.set("n",  ":Cp", ":cp", opts)
vim.keymap.set("n",  ":Cw", ":cw", opts)
vim.keymap.set("n",  ":Ccl", ":ccl", opts)
vim.keymap.set("n",  ":Vs", ":vs", opts)
vim.keymap.set("n",  ":Sp", ":sp", opts)
