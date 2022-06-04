local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

local actions = require "telescope.actions"
local trouble = require("trouble.providers.telescope")
local icons = require("user.icons")

telescope.setup {
  defaults = {

    prompt_prefix = icons.ui.Telescope .. " ",
    selection_caret = " ",
    path_display = { "smart" },

    mappings = {
      i = {
        ["<C-n>"] = actions.cycle_history_next,
        ["<C-p>"] = actions.cycle_history_prev,

        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,

        ["<Down>"] = actions.move_selection_next,
        ["<Up>"] = actions.move_selection_previous,

        ["<C-c>"] = actions.close,

        ["<CR>"] = actions.select_default,
        ["<C-s>"] = actions.select_horizontal,
        ["<C-v>"] = actions.select_vertical,
        ["<C-t>"] = trouble.open_with_trouble,

        ['<c-x>'] = require('telescope.actions').delete_buffer,

        ["<C-u>"] = actions.preview_scrolling_up,
        ["<C-d>"] = actions.preview_scrolling_down,

        ["<PageUp>"] = actions.results_scrolling_up,
        ["<PageDown>"] = actions.results_scrolling_down,

        ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
        ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
        ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
        -- commented out till I find a fix for sending Meta-Key correctly...
        -- ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
        -- ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
        ["<C-l>"] = actions.complete_tag,
        ["<C-/>"] = actions.which_key, -- keys from pressing <C-/>
        ["<C-h>"] = function(prompt_bufnr) telescope.extensions.hop._hop(prompt_bufnr) end,  -- hop.hop_toggle_selection
        -- custom hop loop to multi selects and sending selected entries to quickfix list
        ["<C-space>"] = function(prompt_bufnr)
          local opts = {
            callback = actions.toggle_selection,
            loop_callback = actions.send_selected_to_qflist,
          }
          require("telescope").extensions.hop._hop_loop(prompt_bufnr, opts)
        end,
      },

      n = {
        ["<esc>"] = actions.close,
        ["<CR>"] = actions.select_default,
        ["<C-s>"] = actions.select_horizontal,
        ["<C-v>"] = actions.select_vertical,
        ["<C-t>"] = trouble.open_with_trouble,

        ['<c-x>'] = require('telescope.actions').delete_buffer,

        ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
        ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
        ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
        -- commented out till I find a fix for sending Meta-Key correctly...
        -- ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
        -- ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

        ["j"] = actions.move_selection_next,
        ["k"] = actions.move_selection_previous,
        ["H"] = actions.move_to_top,
        ["M"] = actions.move_to_middle,
        ["L"] = actions.move_to_bottom,

        ["<Down>"] = actions.move_selection_next,
        ["<Up>"] = actions.move_selection_previous,
        ["gg"] = actions.move_to_top,
        ["G"] = actions.move_to_bottom,

        ["<C-u>"] = actions.preview_scrolling_up,
        ["<C-d>"] = actions.preview_scrolling_down,

        ["<PageUp>"] = actions.results_scrolling_up,
        ["<PageDown>"] = actions.results_scrolling_down,

        ["?"] = actions.which_key,
      },
    },
  },
  -- TODO: (slerer) read about Telescope pickers (:h telescope-file-browser.picker)
  pickers = {
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker

    -- the following limits the live_grep builtin picker to search in same extension files.
    live_grep = {
      additional_args = function(opts)
        if opts.search_all == true then
          return {}
        end
        local args_for_ext = {
          ["py"]  = "-tpy",
          ["cs"]  = "-tcs",
          ["cpp"] = "-tcpp",
          ["c"]   = "-tcpp",
          ["h"]   = "-tcpp",
          ["rs"]  = "-trust",
          ["lua"] = "-tlua"
        }
        return { args_for_ext[vim.bo.filetype] }
      end
    },
  },
  extensions = {
    -- https://github.com/nvim-telescope/telescope-fzf-native.nvim
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    },
    hop = {
      -- the shown `keys` are the defaults, no need to set `keys` if defaults work for you ;)
      keys = {"a", "s", "d", "f", "g", "h", "j", "k", "l", ";",
              "q", "w", "e", "r", "t", "y", "u", "i", "o", "p",
              "A", "S", "D", "F", "G", "H", "J", "K", "L", ":",
              "Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P", },
      -- Highlight groups to link to signs and lines; the below configuration refers to demo
      -- sign_hl typically only defines foreground to possibly be combined with line_hl
      sign_hl = { "WarningMsg", "Title" },
      -- optional, typically a table of two highlight groups that are alternated between
      line_hl = { "CursorLine", "Normal" },
      -- options specific to `hop_loop`
      -- true temporarily disables Telescope selection highlighting
      clear_selection_hl = false,
      -- highlight hopped to entry with telescope selection highlight
      -- note: mutually exclusive with `clear_selection_hl`
      trace_entry = true,
      -- jump to entry where hoop loop was started from
      reset_selection = true,
    },
    media_files = {
      -- filetypes whitelist
      -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
      filetypes = { "png", "webp", "jpg", "jpeg" },
      find_cmd = "rg", -- find command (defaults to `fd`)
    },
    file_browser = {
      -- theme = "ivy",
      -- require("telescope.themes").get_dropdown {
      --   previewer = false,
      --   -- even more opts
      -- },
      mappings = {
        ["i"] = {
          -- your custom insert mode mappings
        },
        ["n"] = {
          -- your custom normal mode mappings
        },
      },
    },
    -- ["ui-select"] = {
    --   require("telescope.themes").get_dropdown {
    --     -- previewer = false,
    --     -- even more opts
    --   },
    -- },
  },
}

telescope.load_extension('harpoon')

telescope.load_extension "ui-select"

--
telescope.load_extension('hop')

-- NOTE: doesn't need this vvv to work?
-- telescope.load_extension('neoclip')

--
telescope.load_extension("lazygit")

--
telescope.load_extension('env')

--
telescope.load_extension('vim_bookmarks')

--
telescope.load_extension("session-lens")

-- https://github.com/jvgrootveld/telescope-zoxide
telescope.load_extension('zoxide')

-- https://github.com/nvim-telescope/telescope-file-browser.nvim
telescope.load_extension "file_browser"

telescope.load_extension "media_files"

telescope.load_extension "fzf"

-- https://github.com/nvim-telescope/telescope-frecency.nvim
telescope.load_extension "frecency"

-- https://github.com/nvim-telescope/telescope-project.nvim
telescope.load_extension "project"
-- lua require'telescope'.extensions.project.project{} to activate picker

-- https://github.com/nvim-telescope/telescope-rg.nvim
telescope.load_extension "live_grep_raw"

-- https://github.com/nvim-telescope/telescope-dap.nvim
telescope.load_extension('dap')
-- Available commands:
-- :Telescope dap commands
-- :Telescope dap configurations
-- :Telescope dap list_breakpoints
-- :Telescope dap variables
-- :Telescope dap frames
-- As functions:
-- require'telescope'.extensions.dap.commands{}
-- require'telescope'.extensions.dap.configurations{}
-- require'telescope'.extensions.dap.list_breakpoints{}
-- require'telescope'.extensions.dap.variables{}
-- require'telescope'.extensions.dap.frames{}
