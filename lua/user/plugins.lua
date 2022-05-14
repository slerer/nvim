local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
local group = vim.api.nvim_create_augroup("packer_user_config", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", { pattern = "plugins.lua", command = "source <afile> | PackerSync", group = group })
-- vim.cmd [[
--   augroup packer_user_config
--     autocmd!
--     autocmd BufWritePost plugins.lua source <afile> | PackerSync
--   augroup end
-- ]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  max_jobs = 8,
  -- max_jobs = 48,
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use "wbthomason/packer.nvim" -- Have packer manage itself
  use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim" -- Useful lua functions used by lots of plugins
  use "windwp/nvim-autopairs" -- Autopairs, integrates with both cmp and treesitter
  use "numToStr/Comment.nvim"
  use "kyazdani42/nvim-web-devicons"
  use { "kyazdani42/nvim-tree.lua" }
  use "tamago324/lir.nvim"
  -- use "kosayoda/nvim-lightbulb"
  use "akinsho/bufferline.nvim"
  use "moll/vim-bbye"
  use "nvim-lualine/lualine.nvim"
  use "akinsho/toggleterm.nvim"
  use "ahmedkhalf/project.nvim"
  use "lewis6991/impatient.nvim"
  use "lukas-reineke/indent-blankline.nvim"
  use "goolord/alpha-nvim"
  use "antoinemadec/FixCursorHold.nvim" -- This is needed to fix lsp doc highlight
  use "folke/which-key.nvim"
  use "unblevable/quick-scope"
  use "phaazon/hop.nvim"
  use "andymass/vim-matchup"
  use "nacro90/numb.nvim"
  use "monaqa/dial.nvim"
  use "norcalli/nvim-colorizer.lua"
  use "windwp/nvim-spectre"
  use "folke/zen-mode.nvim"
  -- use "karb94/neoscroll.nvim"
  use "folke/todo-comments.nvim"

  -- nvim-bqf for better quickfix window.
  use { "kevinhwang91/nvim-bqf", ft = "qf" }
  -- optional -- fzf fun:
  -- "Old-way"
  use {'junegunn/fzf', run = function()
      vim.fn['fzf#install']()
  end
  }
  use "junegunn/fzf.vim"

  -- "New-way"
  use "vijaymarupudi/nvim-fzf"
  -- use "vijaymarupudi/nvim-fzf-commands" -- timed-out, should retry?
  use { 'ibhagwan/fzf-lua',
    -- optional for icon support
    requires = { 'kyazdani42/nvim-web-devicons' }
  }
  -- need to decide what to use ^^^
  -- end of fzf fun --

  use "ThePrimeagen/harpoon"
  use "MattesGroeger/vim-bookmarks"
  -- use "Mephistophiles/surround.nvim"
  use "tpope/vim-repeat"
  use "rcarriga/nvim-notify"
  use "tversteeg/registers.nvim"
  use { "nyngwang/NeoZoom.lua", branch = "neo-zoom-original" }
	use { "SmiteshP/nvim-gps", requires = "nvim-treesitter/nvim-treesitter" }
  use { "michaelb/sniprun", run = "bash ./install.sh" }
  -- use {
  --
  --   "iamcco/markdown-preview.nvim",
  --   run = "cd app && npm install",
  --   ft = "markdown",
  -- }
  use "matbme/JABS.nvim"

  -- Colorschemes
  use "folke/tokyonight.nvim"
  use "lunarvim/darkplus.nvim"
  use "gruvbox-community/gruvbox"
  use "doums/darcula"
  use "sainnhe/gruvbox-material"
  use "phanviet/vim-monokai-pro"
  use "flazz/vim-colorschemes"
  use "chriskempson/base16-vim"
  use "kyazdani42/blue-moon"
  use { "dracula/vim", as = "dracula" }

  -- cmp plugins
  use "hrsh7th/nvim-cmp"
  use "hrsh7th/cmp-buffer" -- buffer completions
  use "hrsh7th/cmp-path" -- path completions
  use "hrsh7th/cmp-cmdline" -- cmdline completions
  use "saadparwaiz1/cmp_luasnip" -- snippet completions
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-emoji"
  use "hrsh7th/cmp-nvim-lua"
  use "f3fora/cmp-spell"

  -- snippets
  use "L3MON4D3/LuaSnip" --snippet engine
  use "rafamadriz/friendly-snippets" -- a bunch of snippets to use
  -- use "honza/vim-snippets"

  -- LSP
  use "neovim/nvim-lspconfig" -- enable LSP
  use "williamboman/nvim-lsp-installer" -- simple to use language server installer
  use "tamago324/nlsp-settings.nvim" -- language server settings defined in json for
  use "jose-elias-alvarez/null-ls.nvim" -- for formatters and linters
  -- need to decide between next two plugins:
  use "simrat39/symbols-outline.nvim"
  use "stevearc/aerial.nvim"
  --
  use "ray-x/lsp_signature.nvim"
  use "b0o/SchemaStore.nvim"
  use { "folke/trouble.nvim", cmd = "TroubleToggle", }
  -- use "github/copilot.vim"
  use "RRethy/vim-illuminate"

  -- Java
  -- use "mfussenegger/nvim-jdtls"

  -- Telescope
  use "nvim-telescope/telescope.nvim"
  use "jvgrootveld/telescope-zoxide"
  use "nvim-telescope/telescope-symbols.nvim"
  use "nvim-telescope/telescope-dap.nvim"
  use { 'nvim-telescope/telescope-live-grep-raw.nvim' }
  use "tom-anders/telescope-vim-bookmarks.nvim"
  use "nvim-telescope/telescope-media-files.nvim"
  use "nvim-telescope/telescope-ui-select.nvim"
  use "nvim-telescope/telescope-file-browser.nvim"
  -- use "nvim-telescope/telescope-fzy-native.nvim"
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use "nvim-telescope/telescope-project.nvim"
  use {
    "nvim-telescope/telescope-frecency.nvim",
    config = function()
      require"telescope".load_extension("frecency")
    end,
    requires = {"tami5/sqlite.lua"}
  }

  -- Treesitter
  use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate", }
  use "JoosepAlviste/nvim-ts-context-commentstring"
  use { "p00f/nvim-ts-rainbow" }
  -- use {'christianchiarulli/nvim-ts-rainbow'}
  use "nvim-treesitter/playground"
  use "windwp/nvim-ts-autotag"
  use "romgrk/nvim-treesitter-context"
  use "mizlan/iswap.nvim" -- Allows for swapping items etc. (:ISwap, :ISwapWith)

  -- Git
  use "lewis6991/gitsigns.nvim"
  use "f-person/git-blame.nvim"
  use { "ruifm/gitlinker.nvim", requires = "nvim-lua/plenary.nvim" }
  use "mattn/vim-gist"
  use "mattn/webapi-vim"
  use "https://github.com/rhysd/conflict-marker.vim" -- UI Component Library for Neovim.

  -- DAP
  use "mfussenegger/nvim-dap"
  use "theHamsta/nvim-dap-virtual-text"
  use "rcarriga/nvim-dap-ui"
  use "Pocco81/DAPInstall.nvim"

  -- General QoL Plugins I'm testing:
  use "ron89/thesaurus_query.vim"
  use "AndrewRadev/splitjoin.vim"
  -- https://github.com/AndrewRadev/sideways.vim
  use "AndrewRadev/sideways.vim"
  use "t9md/vim-choosewin"
  use "nathom/filetype.nvim"
  -- use {
  --   "nathom/filetype.nvim",
  --   config = function()
  --     require("filetype").setup()
  --   end,
  -- }
  use {
    'rmagatti/auto-session',
    config = function()
      require('auto-session').setup {
        log_level = 'info',
        auto_session_suppress_dirs = {'~/', '~/git/'}
      }
    end
  }
  use {
    'rmagatti/session-lens',
    requires = {'rmagatti/auto-session', 'nvim-telescope/telescope.nvim'},
    config = function()
      require('session-lens').setup({--[[your custom config--]]})
    end
  }

  -- OLD plugins here:
  use "AndrewRadev/linediff.vim"
  use "vim-scripts/kwbdi.vim"
  use "machakann/vim-sandwich"
  -- use "tpope/vim-commentary"
  -- use "jeetsukumaran/vim-markology"
  use "mbbill/undotree"
  use "folke/lsp-colors.nvim"
  use "sharkdp/bat"
  use "sharkdp/fd"
  use "BurntSushi/ripgrep"
  use "liuchengxu/vista.vim"
  -- use "kosayoda/nvim-lightbulb"
  use "tpope/vim-fugitive"
  use "junegunn/gv.vim"
  -- use "borissov/fugitive-bitbucketserver"
  -- use "kassio/neoterm"
  use "kevinhwang91/nvim-hlslens" -- Better searching highlighting.
  use "vim-scripts/IndexedSearch" -- Adds 'Match XX of YY' in status-line when searching.
  use "MunifTanjim/nui.nvim" -- UI Component Library for Neovim.

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
