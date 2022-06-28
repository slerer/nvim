local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  vim.notify('Failed to require "nvim-treesitter.configs"...')
	return
end

local ft_to_parser = require"nvim-treesitter.parsers".filetype_to_parsername
ft_to_parser.motoko = "typescript"

local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.markdown.filetype_to_parsername = "octo"

configs.setup({
	ensure_installed = { "javascript", "html", "bash", "lua", "json", "cpp", "rust", "python", "vim" }, -- one of "all" or a list of languages
	sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
	ignore_install = { "" }, -- List of parsers to ignore installing
	highlight = {
		enable = true, -- false will disable the whole extension
		disable = { "css", "markdown" }, -- list of language that will be disabled
		additional_vim_regex_highlighting = true,
    use_languagetree = true,
	},
	autopairs = {
		enable = true,
	},
	indent = { enable = true, disable = { "python", "css" } },
	context_commentstring = {
		enable = true,
		enable_autocmd = false,
	},
	autotag = {
		enable = true,
		disable = { "xml" },
	},
	rainbow = {
		enable = true,
		colors = {
			"Gold",
			"Orchid",
			"DodgerBlue",
			"Cornsilk",
			"Salmon",
			"LawnGreen",
		},
		disable = { "html" },
	},
	playground = {
		enable = true,
	},
  refactor = {
    highlight_definitions = {
      enable = true,
      -- Set to false if you have an `updatetime` of ~100.
      clear_on_cursor_move = true,
    },
    -- highlight_current_scope = { enable = true },
    smart_rename = {
      enable = true,
      keymaps = {
        -- smart_rename = "grr",
      },
    },
    navigation = {
      enable = true,
      keymaps = {
        goto_definition = "gnd",
        -- list_definitions = "gnD",
        -- list_definitions_toc = "gO",
        -- goto_next_usage = "<a-*>",
        -- goto_previous_usage = "<a-#>",
      },
    },
  },
})

local iswap_status, iswap = pcall(require, "iswap")
if not iswap_status then
  vim.notify('Failed to require "iswap"...')
else
  iswap.setup({
    autoswap = true,
  })
end
