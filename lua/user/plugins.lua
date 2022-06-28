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
  vim.notify('Failed to require "packer"...')
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
  use "anuvyklack/nvim-keymap-amend"
  use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim" -- Useful lua functions used by lots of plugins
  use "windwp/nvim-autopairs" -- Autopairs, integrates with both cmp and treesitter
  use "numToStr/Comment.nvim"
  -- use { 'kyazdani42/nvim-web-devicons', event = 'VimEnter' }
  use { 'kyazdani42/nvim-web-devicons' }
  use {
    'yamatsum/nvim-nonicons',
    requires = {'kyazdani42/nvim-web-devicons'}
  }
  use { "kyazdani42/nvim-tree.lua" }
  use "tamago324/lir.nvim"
  -- use "kosayoda/nvim-lightbulb"
  use "akinsho/bufferline.nvim"
  use "moll/vim-bbye"
  -- use "windwp/windline.nvim" -- giving lualine a chance...
  use "nvim-lualine/lualine.nvim"
  use "akinsho/toggleterm.nvim"
  use "ahmedkhalf/project.nvim"
  use "lewis6991/impatient.nvim"
  use "lukas-reineke/indent-blankline.nvim"
  -- Add indent object for vim (useful for languages like Python)
  use{ "michaeljsmith/vim-indent-object" }
  use "goolord/alpha-nvim"
  use "antoinemadec/FixCursorHold.nvim" -- This is needed to fix lsp doc highlight
  use "folke/which-key.nvim"
  use "unblevable/quick-scope"
  -- hop or leap?-------
  use "phaazon/hop.nvim"
  use "ggandor/leap.nvim"
  ----------------------
  use "andymass/vim-matchup"
  use "nacro90/numb.nvim"
  use "monaqa/dial.nvim"
  use "norcalli/nvim-colorizer.lua"
  use "windwp/nvim-spectre"
  use "folke/zen-mode.nvim"
  -- use "karb94/neoscroll.nvim"
  use "folke/todo-comments.nvim"
  use "nanotee/zoxide.vim"

  -- nvim-bqf for better quickfix window.
  use { "kevinhwang91/nvim-bqf" }
  -- optional -- fzf fun:
  -- "Old-way"
  use {'junegunn/fzf', run = function()
      vim.fn['fzf#install']()
  end
  }
  use "junegunn/fzf.vim"

  -- "New-way"
  use "vijaymarupudi/nvim-fzf"
  use "vijaymarupudi/nvim-fzf-commands" -- timed-out, should retry?
  use { 'ibhagwan/fzf-lua',
    -- optional for icon support
    requires = { 'kyazdani42/nvim-web-devicons' }
  }
  -- need to decide what to use ^^^
  -- end of fzf fun --

  use "MattesGroeger/vim-bookmarks"
  -- use "Mephistophiles/surround.nvim"
  use "tpope/vim-repeat"
  use "rcarriga/nvim-notify"
  use "tversteeg/registers.nvim"
  use { "nyngwang/NeoZoom.lua", branch = "neo-zoom-original" }
	use { "SmiteshP/nvim-gps", requires = "nvim-treesitter/nvim-treesitter" }
  use { "michaelb/sniprun", run = "bash ./install.sh" }
  use "matbme/JABS.nvim"

  -- Colorschemes
  use { "folke/tokyonight.nvim" }
  use { "lunarvim/darkplus.nvim" }
  use { "gruvbox-community/gruvbox" }
  use { "sainnhe/gruvbox-material" }
  use { "flazz/vim-colorschemes" }
  use { "chriskempson/base16-vim" }
  use { "lifepillar/vim-gruvbox8" }
  use { "navarasu/onedark.nvim" }
  use { "sainnhe/edge" }
  use { "sainnhe/sonokai" }
  use { "shaunsingh/nord.nvim" }
  use { "NTBBloodbath/doom-one.nvim" }
  use { "sainnhe/everforest" }
  use { "EdenEast/nightfox.nvim" }
  use { "rebelot/kanagawa.nvim" }
  use { "eddyekofo94/gruvbox-flat.nvim",
        config = function()
          vim.g.gruvbox_flat_style = "hard"
          -- vim.g.gruvbox_sidebars = true
          -- vim.g.gruvbox_dark_sidebar = true
          -- vim.g.gruvbox_theme = { ToDo = { bg = "" } }
        end
  }
  use { "Mofiqul/vscode.nvim",
        config = function()
          -- Lua:
          -- For dark theme
          vim.g.vscode_style = "dark"
          -- For light theme
          -- vim.g.vscode_style = "light"
          -- Enable transparent background
          -- vim.g.vscode_transparent = 1
          -- Enable italic comment
          -- vim.g.vscode_italic_comment = 1
          -- Disable nvim-tree background color
          -- vim.g.vscode_disable_nvimtree_bg = true
          -- vim.cmd([[colorscheme vscode]])
        end,
  }
  use {'lewis6991/github_dark.nvim'}

  -- cmp plugins
  use { "hrsh7th/nvim-cmp" }
  use { "hrsh7th/cmp-buffer" } -- buffer completions
  use { "hrsh7th/cmp-path" } -- path completions
  use { "hrsh7th/cmp-cmdline" } -- cmdline completions
  use { "saadparwaiz1/cmp_luasnip" } -- snippet completions
  use { "hrsh7th/cmp-nvim-lsp" }
  use { "hrsh7th/cmp-emoji" }
  use { "hrsh7th/cmp-nvim-lua" }
  use { 'hrsh7th/cmp-nvim-lsp-signature-help' }
  use { "f3fora/cmp-spell" }
  use { "hrsh7th/cmp-omni" }
  use { "rcarriga/cmp-dap" }
  use { "petertriho/cmp-git", requires = "nvim-lua/plenary.nvim" }

  -- snippets
  use {
    'L3MON4D3/LuaSnip',
    -- after = 'nvim-cmp',
  } --snippet engine
  use "rafamadriz/friendly-snippets" -- a bunch of snippets to use
  -- use "honza/vim-snippets"

  -- LSP
  use { "neovim/nvim-lspconfig" } -- enable LSP
  use "williamboman/nvim-lsp-installer" -- simple to use language server installer
  use "tamago324/nlsp-settings.nvim" -- language server settings defined in json for
  use "jose-elias-alvarez/null-ls.nvim" -- for formatters and linters
  -- need to decide between next two plugins:
  use "simrat39/symbols-outline.nvim"
  use "stevearc/aerial.nvim"
  --
  use({
    "glepnir/lspsaga.nvim",
    branch = "main",
    config = function()
      local saga = require("lspsaga")

      saga.init_lsp_saga({
        -- your configuration
      })
    end,
  })
  -- use "ray-x/lsp_signature.nvim"
  use "b0o/SchemaStore.nvim"
  --
  use { "stsewd/isort.nvim", run = ":UpdateRemotePlugins"}

  -- use "github/copilot.vim"
  use "RRethy/vim-illuminate"
  use{ "itchyny/vim-highlighturl" } -- Highlight URLs inside vim
  use { 'jdhao/whitespace.nvim' } -- show and trim trailing whitespaces
  use { "smjonas/inc-rename.nvim", config = function() require("inc_rename").setup() end, }
  -- Java
  -- use "mfussenegger/nvim-jdtls"

  -- DAP
  use "mfussenegger/nvim-dap"
  use "theHamsta/nvim-dap-virtual-text"
  use "rcarriga/nvim-dap-ui"
  use "mfussenegger/nvim-dap-python"
  -- use "Pocco81/dap-buddy.nvim"  -- these two Pocco81 plug-ins used to assist with easy install of DAP adapters, but
  -- are broken till further notice.
  -- use "Pocco81/DAPInstall.nvim"
  -- experimental:
  use "HiPhish/debugpy.nvim"  -- :Debugpy module|program|attach <name> <args>

  use { "rcarriga/vim-ultest",
        requires = {"vim-test/vim-test"},
        run = ":UpdateRemotePlugins" }
  -- new plugin vvv from author of ^^^, still wonky but really nice.
  -- TODO: add commands for Neotest commands.
  use { -- TODO: need to setup support for debugging a test on-the-fly.
    "rcarriga/neotest",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      "rcarriga/neotest-python",
      "rcarriga/neotest-plenary",
    }
  }
  use { "folke/trouble.nvim", requires = "kyazdani42/nvim-web-devicons" }
  -- use { "onsails/diaglist.nvim" }

  -- Telescope
  use { "ThePrimeagen/harpoon" }
  use { "nvim-telescope/telescope.nvim",
    requires = {
      { "zane-/cder.nvim" },
      { "nvim-telescope/telescope-live-grep-args.nvim" },
      { "jvgrootveld/telescope-zoxide" },
      { "nvim-telescope/telescope-symbols.nvim" },
      { "nvim-telescope/telescope-dap.nvim" },
      { 'nvim-telescope/telescope-live-grep-args.nvim' },
      { "tom-anders/telescope-vim-bookmarks.nvim" },
      { "nvim-telescope/telescope-media-files.nvim" },
      { "nvim-telescope/telescope-ui-select.nvim" },
      { "nvim-telescope/telescope-file-browser.nvim" },
      { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
      { "nvim-telescope/telescope-frecency.nvim", requires = {"tami5/sqlite.lua"} },
      { "LinArcX/telescope-env.nvim" },
      { "shift-d/scratch.nvim" },
    }
  }
  -- use "nvim-telescope/telescope-fzy-native.nvim"

  use { -- TODO: read docs for this:
    -- BUG: breaks yanking to "0 on some occasions :( - Fix this!!!
    "AckslD/nvim-neoclip.lua",
    requires = {
      {'tami5/sqlite.lua', module = 'sqlite'},
      -- you'll need at least one of these
      {'nvim-telescope/telescope.nvim'},
      -- {'ibhagwan/fzf-lua'},
    },
  }
  use { 'nvim-telescope/telescope-hop.nvim' }
  -- use { 'nvim-telescope/telescope-hop.nvim', after = 'telescope.nvim' }

  -- Treesitter
  -- TODO: add 'after =' to the rest of the dependent on treesitter
  -- use { "nvim-treesitter/nvim-treesitter", event = 'BufEnter', run = ":TSUpdate" }
  use { "nvim-treesitter/nvim-treesitter",
    run = ":lua pcall(vim.cmd, 'TSUpdate')",
    requires = {
      { "JoosepAlviste/nvim-ts-context-commentstring" },
      { "p00f/nvim-ts-rainbow" },
      { "nvim-treesitter/playground" },
      { "windwp/nvim-ts-autotag" },
      { "romgrk/nvim-treesitter-context" },
      { "nvim-treesitter/nvim-treesitter-refactor" },
      { "mizlan/iswap.nvim" }, -- Allows for swapping items etc. (:ISwap, :ISwapWith)
      { "wellle/targets.vim" },
    },
  }
  -- use {'christianchiarulli/nvim-ts-rainbow'}

  -- Git
  use "lewis6991/gitsigns.nvim"
  use "f-person/git-blame.nvim" -- Do I still need this one? gitsigns and fugitive does similar things.
  use { "ruifm/gitlinker.nvim", requires = "nvim-lua/plenary.nvim" } -- TODO: fix the regex for stash and github.pie
  use "mattn/vim-gist" -- TODO: test this
  use "mattn/webapi-vim" -- TODO: test this -- UI Component Library for Neovim.
  use "https://github.com/rhysd/conflict-marker.vim" -- TODO: test this
  -- NOTE: Testing these:
  use "kdheepak/lazygit.nvim"
  use {'Odie/gitabra', opt = true, cmd = {'Gitabra'} }
  -- should give this a try:
  -- use "akinsho/git-conflict.nvim"
  use { -- github interface for PRs
    'pwntester/octo.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      'kyazdani42/nvim-web-devicons',
    },
    config = function ()
      require"octo".setup({
        github_hostname = "github.pie.apple.com", -- GitHub Enterprise host,
      })
    end
  }

  -- General QoL Plugins I'm testing:
  use { "johmsalas/text-case.nvim",
    config = function()
      require('textcase').setup {}
    end
  }
  use "rafcamlet/nvim-luapad"
  use "ron89/thesaurus_query.vim"
  use "AndrewRadev/splitjoin.vim"
  -- https://github.com/AndrewRadev/sideways.vim
  use "AndrewRadev/sideways.vim"
  use "t9md/vim-choosewin"
  use "mickael-menu/zk-nvim"
  use "stsewd/sphinx.nvim"
  use({
    "kwkarlwang/bufresize.nvim",
    config = function()
        local opts = { noremap=true, silent=true }
        require("bufresize").setup(opts)
    end,
  })
  use {'kevinhwang91/nvim-ufo', requires = 'kevinhwang91/promise-async'}
  use{ "anuvyklack/pretty-fold.nvim",
    requires = 'anuvyklack/nvim-keymap-amend', -- only for preview
  }
  use {
    'bennypowers/nvim-regexplainer',
    requires = {
      'nvim-treesitter/nvim-treesitter',
      'MunifTanjim/nui.nvim', }
  }
  use {
  "danymat/neogen",
  config = function()
    require('neogen').setup {
      enabled = true,
      languages = {
        python = {
          template = {
            annotation_convention = "reST"          }
          },
        }
      }
    end,
      requires = "nvim-treesitter/nvim-treesitter",
      -- Uncomment next line if you want to follow only stable versions
      tag = "*",
      snippet_engine = "luasnip",
    }
  -- use {
  --   "luukvbaal/stabilize.nvim",
  --   config = function() require("stabilize").setup({ nested = "QuickFixCmdPost,DiagnosticChanged *" }) end
  -- }

  -- Testing Markdown stuff:
  use {"ellisonleao/glow.nvim", branch = 'main'}
  use{
    "iamcco/markdown-preview.nvim",
    run = function()
      fn["mkdp#util#install"]()
    end,
    ft = { "markdown" },
  }
  use { "skanehira/preview-markdown.vim" }

  -- Should make neovim load files (and startup in general...) faster. Need to read on how to properly load this vvv
  -- use "nathom/filetype.nvim"
  -- Had some annoying things with automatic session. Will give it another try when I have the time to mess around.
  -- remember the extension is also loaded in telescope.lua
  use { 'rmagatti/auto-session' }
  use { 'rmagatti/session-lens', requires = {'rmagatti/auto-session', 'nvim-telescope/telescope.nvim'} }

  use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' , config = function() require("diffview").setup({}) end }
  -- OLD plugins here:
  use "AndrewRadev/linediff.vim"
  -- use "vim-scripts/kwbdi.vim"
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
  -- Show match number and index for searching
  -- use "vim-scripts/IndexedSearch" -- Adds 'Match XX of YY' in status-line when searching.
  use "MunifTanjim/nui.nvim" -- UI Component Library for Neovim.
  use {
    'm-demare/hlargs.nvim',
    requires = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require('hlargs').setup({})
    end

  }
  use {
    'kevinhwang91/nvim-hlslens',
    config = function()
      local kopts = {noremap = true, silent = true}

      vim.api.nvim_set_keymap('n', 'n',
          [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
          kopts)
      vim.api.nvim_set_keymap('n', 'N',
          [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
          kopts)
      vim.api.nvim_set_keymap('n', '*', [[*<Cmd>lua require('hlslens').start()<CR>]], kopts)
      vim.api.nvim_set_keymap('n', '#', [[#<Cmd>lua require('hlslens').start()<CR>]], kopts)
      vim.api.nvim_set_keymap('n', 'g*', [[g*<Cmd>lua require('hlslens').start()<CR>]], kopts)
      vim.api.nvim_set_keymap('n', 'g#', [[g#<Cmd>lua require('hlslens').start()<CR>]], kopts)
      require('hlslens').setup({
        calm_down = true,
        -- nearest_only = true,
        -- nearest_float_when = 'always'
      })
    end

  }
  use "FooSoft/vim-argwrap"
  -- use "tpope/vim-characterize"

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
