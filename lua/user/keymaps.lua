local opts = { noremap = true, silent = true }
local opts_nowait = { noremap = true, silent = true, nowait = true }
local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
-- keymap("", "<Space>", "<Nop>", opts)
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
keymap("n", "s", "<NOP>", opts)
-- Remap j and k to act as expected when used on long, wrapped, lines
keymap("n", "j", "gj", opts)
keymap("n", "k", "gk", opts)
-- Same for <Down> and <Up>
keymap("n", "<Down>", "gj", opts)
keymap("n", "<Up>", "gk", opts)
keymap("n", "<leader>xx", "<cmd>TroubleToggle<cr>", opts)
-- jump to the next item, skipping the groups
keymap("n", "]t", "<cmd>lua require('trouble').next({skip_groups = true, jump = true})<cr>", opts)
-- jump to the previous item, skipping the groups
keymap("n", "[t", "<cmd>lua require('trouble').previous({skip_groups = true, jump = true})<cr>", opts)

-- Better window navigation
-- keymap("n", "<C-h>", "<C-w>h", opts)
-- keymap("n", "<C-j>", "<C-w>j", opts)
-- keymap("n", "<C-k>", "<C-w>k", opts)
-- keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
-- keymap("n", "<C-Up>", ":resize -2<CR>", opts)
-- keymap("n", "<C-Down>", ":resize +2<CR>", opts)
-- keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
-- keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Naviagate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Move text up and down
-- TODO: Currently Alt or Meta key does not work for my setup with Alacritty...
keymap("n", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
keymap("n", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)

-- Insert --
-- Press jk fast to enter
-- keymap("i", "jk", "<ESC>", opts)
keymap("i", "<C-c>", "<ESC>", opts)
keymap("i", "<C-e>", "<end>", opts)
keymap("i", "<C-a>", "<home>", opts)
keymap("i", "<C-u>", "<C-g>u<C-u>", opts)
keymap("i", "<C-r>", "<C-g>u<C-r>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "J", ":move '>+1<CR>gv-gv", opts)
keymap("v", "K", ":move '<-2<CR>gv-gv", opts)
-- keymap("v", "<A-j>", ":m .+1<CR>==", opts)
-- keymap("v", "<A-k>", ":m .-2<CR>==", opts)
-- keymap("v", "<M-j>", ":m .+1<CR>==", opts)
-- keymap("v", "<M-k>", ":m .-2<CR>==", opts)

-- pasting without overwriting "register
-- keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
-- keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
-- keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Terminal --
-- Better terminal navigation
keymap("t", "<C-o>", "<C-\\><C-N>", term_opts)
-- keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
-- keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
-- keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
-- keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

-- Custom
keymap("n", "<esc><esc>", "<cmd>nohlsearch<cr>", opts)
-- keymap("n", "<C-/>", "<cmd>nohlsearch<cr>", opts)
keymap("n", "<F1>", ":e ~/.my_notes/<cr>", opts)
keymap("n", "<F3>", "<cmd>Telescope resume<cr>", opts)
keymap("n", "<F4>", ":UndotreeToggle<cr>", opts)
keymap("n", "<leader>u", ":UndotreeToggle<cr>", opts)
keymap("n", "<F5>", "<cmd>Telescope commands<CR>", opts)
-- keymap( "n", "<F6>",
--   [[:echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">" . " FG:" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"fg#")<CR>]],
--   opts
-- )
-- keymap("n", "<F7>", "<cmd>TSHighlightCapturesUnderCursor<cr>", opts)
keymap("n", "<F8>", ":Vista!!<CR>", opts)
keymap("n", "<space><space>", ":Vista finder<CR>", opts)
-- keymap("n", "<F11>", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
-- keymap("n", "<F12>", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
keymap("v", "//", [[y/\V<C-R>=escape(@",'/\')<CR><CR>]], opts)
-- keymap(
--   "n",
--   "<C-p>",
--   "<cmd>lua require('telescope.builtin').git_files(require('telescope.themes').get_dropdown{previewer = false})<cr>",
--   opts
-- )
keymap( "n", "<C-p>", "<cmd>lua require('telescope.builtin').git_files()<cr>", opts)
vim.keymap.set("n",
               "<leader><leader>",
               "<Cmd>lua require('telescope').extensions.frecency.frecency()<CR>",
               { desc = 'Find (F)Recent Files', silent = true })
keymap("n", "<C-t>", "<cmd>lua vim.lsp.buf.document_symbol()<cr>", opts)
-- keymap("n", "<C-z>", "<cmd>ZenMode<cr>", opts)
keymap("n", "<c-n>", ":e ~/.my_notes/<cr>", opts)

keymap("n", "-", ":lua require'lir.float'.toggle()<cr>", opts)
-- keymap("n", "gx", [[:silent execute '!$BROWSER ' . shellescape(expand('<cfile>'), 1)<CR>]], opts)
-- Change '<CR>' to whatever shortcut you like :)
vim.api.nvim_set_keymap("n", "<CR>", ":up|noh<CR>", opts_nowait)
vim.api.nvim_set_keymap("n", "<C-w>z", "<cmd>NeoZoomToggle<CR>", opts_nowait)
vim.api.nvim_set_keymap("n", "=", "<Plug>(choosewin)", opts)
-- vim.api.nvim_set_keymap(
--   "n",
--   "=",
--   "<cmd>JABSOpen<cr>",
--   { noremap = true, silent = true, nowait = true }
-- )

vim.api.nvim_set_keymap("n", "<leader>json", ":%!python -m json.tool<CR>", opts) -- Formatting a JSON file
vim.api.nvim_set_keymap("n", "<C-j>", "i<CR><ESC>", opts) -- Formatting a JSON file
vim.api.nvim_set_keymap("n",  "<C-h>", "<cmd>SidewaysLeft<CR>", opts)
vim.api.nvim_set_keymap("n",  "<C-l>", "<cmd>SidewaysRight<CR>", opts)
-- vim.api.nvim_set_keymap("n", "<leader>spell", ":set spell!<CR>", opts)
-- vim.api.nvim_set_keymap("n", "<leader>wrap", ":set wrap!<CR>", opts)
