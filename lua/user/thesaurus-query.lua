-- https://github.com/Ron89/thesaurus_query.vim
local opts = { noremap = true, silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

-- NOTE: no need to define keymaps - already done by the plugin and will throw an error due to <unique> option...

-- This routine check the synonyms of the word under cursor or replace it with the candidate chosen by user. The
-- corresponding non-replacing routine is defined as ThesaurusQueryLookupCurrentWord. User may choose to use it if you
-- prefer the split buffer display of result over the word replacement routine.
-- keymap("n", "<leader>cs", "<cmd>ThesaurusQueryReplaceCurrentWord<CR>", opts)
-- Another might-be-useful routine is the one to query synonym for and replace a multi-word phrase covered in visual
-- mode, using the same key mapping <Leader>cs
-- keymap("v", "<leader>cs", "\"ky:ThesaurusQueryReplace <C-r>k<CR>", opts)
-- The phrase covered in visual mode can be in a same line, or wrapped in two or more lines.
-- Also, this plugin support Vim's builtin `completefunc` insert mode autocomplete function. To invoke it, use keybinding
-- `ctrl-x ctrl-u` in insert mode. This function resembles Vim's own thesaurus checking function, but using online
-- resources for matchings.

-- Finally, this plugin support thesaurus checkup for manually input through command mode command :Thesaurus.
--  ```:Thesaurus your phrase```

-- options:
-- mthesaur_txt queries from local mthesaur.txt. It is another useful option when you don't have any internet access at
-- all. For this backend to work, be sure to download the file from gutenberg.org
-- (http://www.gutenberg.org/files/3202/files/) and place it under "~/.vim/thesaurus". If you place the file elsewhere,
-- change global variable g:tq_mthesaur_file to point to the file you downloaded, eg. put the following line let
-- g:tq_mthesaur_file="~/.config/nvim/thesaurus/mthesaur.txt" into your .vimrc file if your mthesaur.txt is placed in
-- folder "~/.config/nvim/thesaurus/".
vim.g.tq_mthesaur_file = "~/.config/nvim/thesaurus/mthesaur.txt"
